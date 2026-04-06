import React, { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { useLiveQuery } from 'dexie-react-hooks';
import { ChevronLeft, Plus, GripVertical, Trash2, Search, X } from 'lucide-react';
import { DndContext, closestCenter, KeyboardSensor, PointerSensor, useSensor, useSensors } from '@dnd-kit/core';
import { arrayMove, SortableContext, sortableKeyboardCoordinates, verticalListSortingStrategy, useSortable } from '@dnd-kit/sortable';
import { CSS } from '@dnd-kit/utilities';
import { db, TemplateExercise, Exercise, TemplateSet, SetType } from '@/database/db';
import { cn } from '@/core/utils/cn';

// --- Exercise Picker Modal ---
function ExercisePicker({ onClose, onSelect }: { onClose: () => void, onSelect: (ex: Exercise) => void }) {
  const [search, setSearch] = useState('');
  const exercises = useLiveQuery(() => 
    db.exercises.filter(ex => ex.name.toLowerCase().includes(search.toLowerCase())).toArray()
  , [search]) || [];

  return (
    <div className="fixed inset-0 z-50 flex flex-col bg-white dark:bg-gray-900">
      <div className="flex items-center justify-between border-b border-gray-200 p-4 dark:border-gray-800">
        <h2 className="text-xl font-bold text-gray-900 dark:text-white">Select Exercise</h2>
        <button onClick={onClose} className="text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white">
          <X size={24} />
        </button>
      </div>
      <div className="p-4">
        <div className="relative">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" size={20} />
          <input
            type="text"
            placeholder="Search exercises..."
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            className="w-full rounded-xl border border-gray-200 bg-gray-50 py-2.5 pl-10 pr-4 text-gray-900 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-800 dark:text-white"
          />
        </div>
      </div>
      <div className="flex-1 overflow-y-auto p-4 space-y-2">
        {exercises.map(ex => (
          <div 
            key={ex.id}
            onClick={() => onSelect(ex)}
            className="flex cursor-pointer items-center justify-between rounded-xl bg-gray-50 p-4 hover:bg-gray-100 dark:bg-gray-800 dark:hover:bg-gray-750"
          >
            <span className="font-medium text-gray-900 dark:text-white">{ex.name}</span>
            <span className="text-xs text-gray-500">{ex.primaryMuscle}</span>
          </div>
        ))}
      </div>
    </div>
  );
}

// --- Sortable Exercise Card ---
function SortableExerciseCard({ 
  item, 
  exercise, 
  onUpdate, 
  onRemove,
  isSuperset,
  prevIsSameSuperset,
  nextIsSameSuperset,
  onLinkToPrevious,
  canLinkToPrevious
}: { 
  key?: React.Key,
  item: TemplateExercise, 
  exercise?: Exercise, 
  onUpdate: (id: number, changes: Partial<TemplateExercise>) => void,
  onRemove: (id: number) => void,
  isSuperset?: boolean,
  prevIsSameSuperset?: boolean,
  nextIsSameSuperset?: boolean,
  onLinkToPrevious?: () => void,
  canLinkToPrevious?: boolean
}) {
  const { attributes, listeners, setNodeRef, transform, transition } = useSortable({ id: item.id! });
  
  const style = {
    transform: CSS.Transform.toString(transform),
    transition,
  };

  const updateSet = (index: number, field: keyof TemplateSet, value: any) => {
    const newSets = [...item.sets];
    newSets[index] = { ...newSets[index], [field]: value };
    onUpdate(item.id!, { sets: newSets });
  };

  const addSet = () => {
    const lastSet = item.sets[item.sets.length - 1] || { type: 'working', reps: 8, weight: 0 };
    onUpdate(item.id!, { sets: [...item.sets, { ...lastSet }] });
  };

  const removeSet = (index: number) => {
    if (item.sets.length <= 1) return;
    const newSets = item.sets.filter((_, i) => i !== index);
    onUpdate(item.id!, { sets: newSets });
  };

  return (
    <div ref={setNodeRef} style={style} className="relative mb-4">
      {isSuperset && (
        <div className={cn(
          "absolute left-2 w-1 bg-primary z-10",
          prevIsSameSuperset ? "-top-4" : "top-4 rounded-t-full",
          nextIsSameSuperset ? "-bottom-4" : "bottom-4 rounded-b-full"
        )} />
      )}
      <div className={cn(
        "rounded-xl border border-gray-200 bg-white shadow-sm dark:border-gray-800 dark:bg-gray-800",
        isSuperset && "ml-6"
      )}>
        <div className="flex items-center justify-between border-b border-gray-100 p-3 dark:border-gray-700">
          <div className="flex items-center">
            <div {...attributes} {...listeners} className="mr-2 cursor-grab text-gray-400 hover:text-gray-600 dark:hover:text-gray-200">
              <GripVertical size={20} />
            </div>
            <h3 className="font-bold text-gray-900 dark:text-white">{exercise?.name || 'Unknown Exercise'}</h3>
          </div>
          <div className="flex items-center gap-2">
            {canLinkToPrevious && (
              <button 
                onClick={() => {
                  if (isSuperset && prevIsSameSuperset) {
                    onUpdate(item.id!, { supersetGroupId: undefined });
                  } else if (onLinkToPrevious) {
                    onLinkToPrevious();
                  }
                }}
                className="text-xs font-medium text-primary hover:text-primary-dark"
              >
                {isSuperset && prevIsSameSuperset ? 'Unlink' : 'Link Prev'}
              </button>
            )}
            <button onClick={() => onRemove(item.id!)} className="text-gray-400 hover:text-red-500">
              <Trash2 size={18} />
            </button>
          </div>
        </div>
        
        <div className="p-3 space-y-3">
          <div className="flex gap-2">
            <select 
              value={item.setType}
              onChange={(e) => onUpdate(item.id!, { setType: e.target.value as SetType })}
              className="flex-1 rounded-lg border border-gray-200 bg-gray-50 p-2 text-sm text-gray-900 dark:border-gray-700 dark:bg-gray-900 dark:text-white"
            >
              <option value="Straight">Straight Sets</option>
              <option value="Superset">Superset</option>
              <option value="Drop Set">Drop Set</option>
              <option value="AMRAP">AMRAP</option>
              <option value="Timed">Timed</option>
            </select>
            <div className="flex flex-1 items-center rounded-lg border border-gray-200 bg-gray-50 px-2 dark:border-gray-700 dark:bg-gray-900">
              <span className="text-xs text-gray-500">Rest (s)</span>
              <input 
                type="number" 
                value={item.restTime}
                onChange={(e) => onUpdate(item.id!, { restTime: parseInt(e.target.value) || 0 })}
                className="w-full bg-transparent p-2 text-right text-sm text-gray-900 outline-none dark:text-white"
              />
            </div>
          </div>

          <div className="space-y-2">
            <div className="grid grid-cols-12 gap-2 px-2 text-xs font-medium text-gray-500">
              <div className="col-span-1 text-center">Set</div>
              <div className="col-span-3 text-center">Type</div>
              <div className="col-span-3 text-center">Reps</div>
              <div className="col-span-3 text-center">Weight</div>
              <div className="col-span-2 text-center">RPE</div>
            </div>
            
            {item.sets.map((set, idx) => (
              <div key={idx} className="grid grid-cols-12 gap-2 items-center">
                <div className="col-span-1 text-center text-sm font-bold text-gray-700 dark:text-gray-300">
                  {idx + 1}
                </div>
                <div className="col-span-3">
                  <select 
                    value={set.type}
                    onChange={(e) => updateSet(idx, 'type', e.target.value)}
                    className="w-full rounded bg-gray-100 p-1 text-xs text-gray-900 dark:bg-gray-700 dark:text-white"
                  >
                    <option value="working">Working</option>
                    <option value="warmup">Warmup</option>
                    <option value="drop">Drop</option>
                  </select>
                </div>
                <div className="col-span-3">
                  <input 
                    type="number" 
                    value={set.reps}
                    onChange={(e) => updateSet(idx, 'reps', parseInt(e.target.value) || 0)}
                    className="w-full rounded bg-gray-100 p-1 text-center text-sm text-gray-900 outline-none dark:bg-gray-700 dark:text-white"
                  />
                </div>
                <div className="col-span-3 relative">
                  <input 
                    type="number" 
                    value={set.weight}
                    onChange={(e) => updateSet(idx, 'weight', parseInt(e.target.value) || 0)}
                    className="w-full rounded bg-gray-100 p-1 text-center text-sm text-gray-900 outline-none dark:bg-gray-700 dark:text-white"
                  />
                </div>
                <div className="col-span-2 relative">
                  <input 
                    type="number" 
                    value={set.rpe || ''}
                    placeholder="-"
                    onChange={(e) => updateSet(idx, 'rpe', parseInt(e.target.value) || null)}
                    className="w-full rounded bg-gray-100 p-1 text-center text-sm text-gray-900 outline-none dark:bg-gray-700 dark:text-white"
                  />
                </div>
              </div>
            ))}
          </div>
          
          <button 
            onClick={addSet}
            className="w-full rounded-lg border border-dashed border-gray-300 py-2 text-sm font-medium text-gray-600 hover:bg-gray-50 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-800"
          >
            + Add Set
          </button>

          <input 
            type="text"
            placeholder="Notes (e.g. slow eccentric)"
            value={item.notes || ''}
            onChange={(e) => onUpdate(item.id!, { notes: e.target.value })}
            className="w-full rounded-lg border border-gray-200 bg-gray-50 p-2 text-sm text-gray-900 outline-none focus:border-primary dark:border-gray-700 dark:bg-gray-900 dark:text-white"
          />
        </div>
      </div>
    </div>
  );
}

export default function DayBuilderScreen() {
  const { programId, dayId } = useParams();
  const navigate = useNavigate();
  const [showPicker, setShowPicker] = useState(false);

  const day = useLiveQuery(() => db.template_days.get(Number(dayId)), [dayId]);
  const templateExercises = useLiveQuery(() => 
    db.template_exercises.where('dayId').equals(Number(dayId)).sortBy('order')
  , [dayId]) || [];
  const exercises = useLiveQuery(() => db.exercises.toArray()) || [];

  const sensors = useSensors(
    useSensor(PointerSensor),
    useSensor(KeyboardSensor, { coordinateGetter: sortableKeyboardCoordinates })
  );

  const handleDragEnd = async (event: any) => {
    const { active, over } = event;
    if (active.id !== over.id) {
      const oldIndex = templateExercises.findIndex(i => i.id === active.id);
      const newIndex = templateExercises.findIndex(i => i.id === over.id);
      const newItems = arrayMove(templateExercises, oldIndex, newIndex);
      
      // Update DB
      for (let i = 0; i < newItems.length; i++) {
        await db.template_exercises.update(newItems[i].id!, { order: i });
      }
    }
  };

  const handleAddExercise = async (ex: Exercise) => {
    setShowPicker(false);
    await db.template_exercises.add({
      dayId: Number(dayId),
      exerciseId: ex.id!,
      order: templateExercises.length,
      setType: 'Straight',
      sets: [{ type: 'working', reps: 8, weight: 0 }],
      restTime: ex.restTime || 90,
    });
  };

  const handleUpdateExercise = async (id: number, changes: Partial<TemplateExercise>) => {
    await db.template_exercises.update(id, changes);
  };

  const handleRemoveExercise = async (id: number) => {
    await db.template_exercises.delete(id);
  };

  if (!day) return <div className="p-4">Loading...</div>;

  return (
    <div className="flex h-full flex-col bg-surface dark:bg-surface-dark">
      <div className="sticky top-0 z-10 flex items-center justify-between bg-white p-4 shadow-sm dark:bg-gray-900">
        <div className="flex items-center">
          <button onClick={() => navigate(`/app/programs/${programId}/edit`)} className="mr-4 text-gray-900 dark:text-white">
            <ChevronLeft size={24} />
          </button>
          <h1 className="text-xl font-bold text-gray-900 dark:text-white">{day.name}</h1>
        </div>
      </div>

      <div className="flex-1 overflow-y-auto p-4">
        {templateExercises.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-12 text-center">
            <p className="mb-4 text-gray-500 dark:text-gray-400">No exercises added to this day.</p>
          </div>
        ) : (
          <DndContext sensors={sensors} collisionDetection={closestCenter} onDragEnd={handleDragEnd}>
            <SortableContext items={templateExercises.map(e => e.id!)} strategy={verticalListSortingStrategy}>
              {templateExercises.map((item, index) => {
                const ex = exercises.find(e => e.id === item.exerciseId);
                const isSuperset = item.supersetGroupId != null;
                const prevIsSameSuperset = index > 0 && templateExercises[index - 1].supersetGroupId === item.supersetGroupId;
                const nextIsSameSuperset = index < templateExercises.length - 1 && templateExercises[index + 1].supersetGroupId === item.supersetGroupId;
                const canLinkToPrevious = index > 0;

                const handleLinkToPrevious = () => {
                  if (index > 0) {
                    const prevItem = templateExercises[index - 1];
                    let groupId = prevItem.supersetGroupId;
                    if (!groupId) {
                      groupId = `group-${Date.now()}`;
                      handleUpdateExercise(prevItem.id!, { supersetGroupId: groupId });
                    }
                    handleUpdateExercise(item.id!, { supersetGroupId: groupId });
                  }
                };

                return (
                  <SortableExerciseCard 
                    key={item.id} 
                    item={item} 
                    exercise={ex} 
                    onUpdate={handleUpdateExercise}
                    onRemove={handleRemoveExercise}
                    isSuperset={isSuperset}
                    prevIsSameSuperset={prevIsSameSuperset}
                    nextIsSameSuperset={nextIsSameSuperset}
                    canLinkToPrevious={canLinkToPrevious}
                    onLinkToPrevious={handleLinkToPrevious}
                  />
                );
              })}
            </SortableContext>
          </DndContext>
        )}

        <button 
          onClick={() => setShowPicker(true)}
          className="mt-4 flex w-full items-center justify-center rounded-xl bg-primary/10 py-4 font-bold text-primary transition-colors hover:bg-primary/20 dark:bg-primary/20 dark:text-primary-light dark:hover:bg-primary/30"
        >
          <Plus size={20} className="mr-2" /> Add Exercise
        </button>
      </div>

      {showPicker && <ExercisePicker onClose={() => setShowPicker(false)} onSelect={handleAddExercise} />}
    </div>
  );
}
