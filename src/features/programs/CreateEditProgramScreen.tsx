import React, { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { useLiveQuery } from 'dexie-react-hooks';
import { ChevronLeft, Plus, GripVertical, ChevronDown, ChevronUp, Trash2 } from 'lucide-react';
import { DndContext, closestCenter, KeyboardSensor, PointerSensor, useSensor, useSensors } from '@dnd-kit/core';
import { arrayMove, SortableContext, sortableKeyboardCoordinates, verticalListSortingStrategy, useSortable } from '@dnd-kit/sortable';
import { CSS } from '@dnd-kit/utilities';
import { db, TemplateDay } from '@/database/db';
import { cn } from '@/core/utils/cn';

interface DayWithCount extends TemplateDay {
  exerciseCount: number;
}

function SortableDayCard({ day, onEditName, onRemove, onClick }: { key?: React.Key, day: DayWithCount, onEditName: (id: number, name: string) => void, onRemove: (id: number) => void, onClick: () => void }) {
  const { attributes, listeners, setNodeRef, transform, transition } = useSortable({ id: day.id! });
  
  const style = {
    transform: CSS.Transform.toString(transform),
    transition,
  };

  const [isEditing, setIsEditing] = useState(false);
  const [name, setName] = useState(day.name);

  const handleBlur = () => {
    setIsEditing(false);
    onEditName(day.id!, name);
  };

  return (
    <div ref={setNodeRef} style={style} className="mb-3 flex items-center rounded-xl bg-white p-4 shadow-sm border border-gray-100 dark:border-gray-800 dark:bg-gray-800">
      <div {...attributes} {...listeners} className="mr-3 cursor-grab text-gray-400 hover:text-gray-600 dark:hover:text-gray-200">
        <GripVertical size={20} />
      </div>
      
      <div className="flex-1 cursor-pointer" onClick={onClick}>
        {isEditing ? (
          <input
            autoFocus
            value={name}
            onChange={(e) => setName(e.target.value)}
            onBlur={handleBlur}
            onKeyDown={(e) => e.key === 'Enter' && handleBlur()}
            className="w-full bg-transparent font-bold text-gray-900 outline-none dark:text-white"
            onClick={(e) => e.stopPropagation()}
          />
        ) : (
          <h3 className="font-bold text-gray-900 dark:text-white" onClick={(e) => { e.stopPropagation(); setIsEditing(true); }}>
            {day.name}
          </h3>
        )}
        <p className="text-xs text-gray-500 dark:text-gray-400">
          {day.exerciseCount} {day.exerciseCount === 1 ? 'exercise' : 'exercises'} • Tap to edit
        </p>
      </div>

      <button onClick={(e) => { e.stopPropagation(); onRemove(day.id!); }} className="ml-2 text-gray-400 hover:text-red-500">
        <Trash2 size={18} />
      </button>
    </div>
  );
}

export default function CreateEditProgramScreen() {
  const { id } = useParams();
  const navigate = useNavigate();
  const isEditing = !!id;

  const [name, setName] = useState('');
  const [description, setDescription] = useState('');
  const [loading, setLoading] = useState(false);

  // Load existing data if editing
  useEffect(() => {
    if (isEditing) {
      const load = async () => {
        const program = await db.workout_templates.get(Number(id));
        if (program) {
          setName(program.name);
          setDescription(program.description || '');
        }
      };
      load();
    }
  }, [id, isEditing]);

  const days = useLiveQuery(async () => {
    if (!isEditing) return [];
    const programDays = await db.template_days.where('templateId').equals(Number(id)).sortBy('order');
    const dayIds = programDays.map(d => d.id!);
    const exercises = await db.template_exercises.where('dayId').anyOf(dayIds).toArray();
    
    return programDays.map(d => ({
      ...d,
      exerciseCount: exercises.filter(e => e.dayId === d.id).length
    }));
  }, [id, isEditing]) || [];

  const sensors = useSensors(
    useSensor(PointerSensor),
    useSensor(KeyboardSensor, { coordinateGetter: sortableKeyboardCoordinates })
  );

  const handleDragEnd = async (event: any) => {
    const { active, over } = event;
    if (active.id !== over.id) {
      const oldIndex = days.findIndex(i => i.id === active.id);
      const newIndex = days.findIndex(i => i.id === over.id);
      const newItems = arrayMove(days, oldIndex, newIndex);
      
      for (let i = 0; i < newItems.length; i++) {
        await db.template_days.update(newItems[i].id!, { order: i });
      }
    }
  };

  const addDay = async () => {
    if (!isEditing && !name) {
      alert('Please enter a program name first.');
      return;
    }

    let programId = Number(id);
    if (!isEditing && !programId) {
      programId = await db.workout_templates.add({ name, description });
      const newDay: TemplateDay = {
        templateId: programId,
        name: `Day 1`,
        order: 0,
      };
      await db.template_days.add(newDay);
      navigate(`/app/programs/${programId}/edit`, { replace: true });
      return;
    }

    const newDay: TemplateDay = {
      templateId: programId,
      name: `Day ${days.length + 1}`,
      order: days.length,
    };
    await db.template_days.add(newDay);
  };

  const updateDayName = async (dayId: number, newName: string) => {
    await db.template_days.update(dayId, { name: newName });
  };

  const removeDay = async (dayId: number) => {
    if (confirm('Delete this day and all its exercises?')) {
      await db.template_days.delete(dayId);
      const exercises = await db.template_exercises.where('dayId').equals(dayId).toArray();
      await db.template_exercises.bulkDelete(exercises.map(e => e.id!));
    }
  };

  const handleSave = async () => {
    if (!name.trim()) return;
    setLoading(true);
    
    if (isEditing) {
      await db.workout_templates.update(Number(id), { name, description });
    } else {
      await db.workout_templates.add({ name, description });
    }
    
    setLoading(false);
    navigate('/app/programs');
  };

  return (
    <div className="flex h-full flex-col bg-surface dark:bg-surface-dark">
      <div className="sticky top-0 z-10 flex items-center justify-between bg-white p-4 shadow-sm dark:bg-gray-900">
        <div className="flex items-center">
          <button onClick={() => navigate('/app/programs')} className="mr-4 text-gray-900 dark:text-white">
            <ChevronLeft size={24} />
          </button>
          <h1 className="text-xl font-bold text-gray-900 dark:text-white">{isEditing ? 'Edit Program' : 'New Program'}</h1>
        </div>
        <button 
          onClick={handleSave}
          disabled={loading || !name.trim()}
          className="rounded-lg bg-primary px-4 py-2 text-sm font-medium text-white disabled:opacity-50"
        >
          Save
        </button>
      </div>

      <div className="flex-1 overflow-y-auto p-4 space-y-6">
        <div>
          <label className="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Program Name *</label>
          <input
            type="text"
            value={name}
            onChange={(e) => setName(e.target.value)}
            placeholder="e.g. Push Pull Legs"
            className="w-full rounded-xl border border-gray-300 bg-white px-4 py-3 text-gray-900 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-800 dark:text-white"
          />
        </div>

        <div>
          <label className="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Description</label>
          <textarea
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            rows={3}
            placeholder="Brief description of the program..."
            className="w-full rounded-xl border border-gray-300 bg-white px-4 py-3 text-gray-900 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-800 dark:text-white"
          />
        </div>

        <div>
          <div className="mb-4 flex items-center justify-between">
            <h2 className="text-lg font-bold text-gray-900 dark:text-white">Training Days</h2>
            <button 
              onClick={addDay}
              className="flex items-center text-sm font-medium text-primary"
            >
              <Plus size={16} className="mr-1" /> Add Day
            </button>
          </div>

          {days.length === 0 ? (
            <div className="rounded-xl border border-dashed border-gray-300 p-8 text-center dark:border-gray-700">
              <p className="text-gray-500 dark:text-gray-400">No days added yet.</p>
            </div>
          ) : (
            <DndContext sensors={sensors} collisionDetection={closestCenter} onDragEnd={handleDragEnd}>
              <SortableContext items={days.map(d => d.id!)} strategy={verticalListSortingStrategy}>
                {days.map(day => (
                  <SortableDayCard 
                    key={day.id} 
                    day={day} 
                    onEditName={updateDayName}
                    onRemove={removeDay}
                    onClick={() => navigate(`/app/programs/${id}/day/${day.id}`)}
                  />
                ))}
              </SortableContext>
            </DndContext>
          )}
        </div>
      </div>
    </div>
  );
}
