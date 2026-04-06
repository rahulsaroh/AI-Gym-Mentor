import { Workout, WorkoutSet, Exercise, BodyMeasurement } from '@/database/db';

const SHEETS_API_URL = 'https://sheets.googleapis.com/v4/spreadsheets';

export async function createSpreadsheet(accessToken: string) {
  const response = await fetch(SHEETS_API_URL, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${accessToken}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      properties: {
        title: 'GymLog Pro',
      },
      sheets: [
        {
          properties: {
            title: 'Workout Log',
            gridProperties: { frozenRowCount: 1 },
          },
        },
        {
          properties: {
            title: 'Exercises',
            gridProperties: { frozenRowCount: 1 },
          },
        },
        {
          properties: {
            title: 'Body Stats',
            gridProperties: { frozenRowCount: 1 },
          },
        },
      ],
    }),
  });

  if (!response.ok) {
    const error = await response.json();
    throw new Error(error.error?.message || 'Failed to create spreadsheet');
  }

  const spreadsheet = await response.json();
  const spreadsheetId = spreadsheet.spreadsheetId;

  // Format headers
  await fetch(`${SHEETS_API_URL}/${spreadsheetId}:batchUpdate`, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${accessToken}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      requests: [
        {
          updateCells: {
            range: { sheetId: spreadsheet.sheets[0].properties.sheetId, startRowIndex: 0, endRowIndex: 1 },
            rows: [{
              values: [
                'Date', 'Day', 'Workout Name', 'Exercise', 'Set#', 'Set Type', 'Weight(kg)', 'Reps', 'RPE', 'Est 1RM', 'Volume(kg)', 'Is PR', 'Exercise Notes', 'Workout Notes'
              ].map(v => ({ userEnteredValue: { stringValue: v }, userEnteredFormat: { textFormat: { bold: true } } }))
            }],
            fields: 'userEnteredValue,userEnteredFormat.textFormat.bold'
          }
        },
        {
          updateCells: {
            range: { sheetId: spreadsheet.sheets[1].properties.sheetId, startRowIndex: 0, endRowIndex: 1 },
            rows: [{
              values: [
                'Name', 'Primary Muscle', 'Secondary Muscle', 'Equipment', 'Set Type', 'Rest Time(s)', 'Instructions', 'Is Custom'
              ].map(v => ({ userEnteredValue: { stringValue: v }, userEnteredFormat: { textFormat: { bold: true } } }))
            }],
            fields: 'userEnteredValue,userEnteredFormat.textFormat.bold'
          }
        },
        {
          updateCells: {
            range: { sheetId: spreadsheet.sheets[2].properties.sheetId, startRowIndex: 0, endRowIndex: 1 },
            rows: [{
              values: [
                'Date', 'Bodyweight(kg)', 'Body Fat(%)', 'Chest(cm)', 'Waist(cm)', 'Hips(cm)', 'Left Arm(cm)', 'Right Arm(cm)', 'Left Thigh(cm)', 'Right Thigh(cm)', 'Calves(cm)'
              ].map(v => ({ userEnteredValue: { stringValue: v }, userEnteredFormat: { textFormat: { bold: true } } }))
            }],
            fields: 'userEnteredValue,userEnteredFormat.textFormat.bold'
          }
        }
      ]
    })
  });

  return spreadsheet;
}

export async function appendWorkout(accessToken: string, spreadsheetId: string, workout: Workout, sets: WorkoutSet[], exercises: Exercise[]) {
  const rows: any[][] = [];
  const dateObj = new Date(workout.date);
  const dateStr = dateObj.toLocaleDateString();
  const dayStr = dateObj.toLocaleDateString(undefined, { weekday: 'short' });

  sets.forEach(set => {
    const ex = exercises.find(e => e.id === set.exerciseId);
    if (!ex) return;

    const est1RM = set.weight * (1 + set.reps / 30);
    const volume = set.weight * set.reps;

    rows.push([
      dateStr,
      dayStr,
      workout.name,
      ex.name,
      set.setNumber,
      set.type,
      set.weight,
      set.reps,
      set.rpe || '',
      Math.round(est1RM),
      volume,
      '', // Is PR (could calculate this, but leaving blank for now)
      '', // Exercise Notes
      workout.notes || ''
    ]);
  });

  if (rows.length === 0) return;

  const response = await fetch(`${SHEETS_API_URL}/${spreadsheetId}/values/Workout Log!A:N:append?valueInputOption=USER_ENTERED`, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${accessToken}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      values: rows,
    }),
  });

  if (!response.ok) {
    const error = await response.json();
    throw new Error(error.error?.message || 'Failed to append workout');
  }
}

export async function syncBodyMeasurement(accessToken: string, spreadsheetId: string, m: BodyMeasurement) {
  const dateStr = new Date(m.date).toLocaleDateString();
  const row = [
    dateStr,
    m.weight || '',
    m.bodyFat || '',
    m.chest || '',
    m.waist || '',
    m.hips || '',
    m.leftArm || '',
    m.rightArm || '',
    m.leftThigh || '',
    m.rightThigh || '',
    m.calves || ''
  ];

  const response = await fetch(`${SHEETS_API_URL}/${spreadsheetId}/values/Body Stats!A:K:append?valueInputOption=USER_ENTERED`, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${accessToken}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      values: [row],
    }),
  });

  if (!response.ok) {
    const error = await response.json();
    throw new Error(error.error?.message || 'Failed to append body measurement');
  }
}
