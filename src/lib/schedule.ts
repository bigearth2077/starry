// src/lib/schedule.ts
import { addDays, isBefore, isEqual } from "date-fns";

export const weekdayOf = (d: Date) => d.getDay();

/** 列举闭区间 [start, end] 内匹配 weekdays(0..6) 的所有日期 */
export function enumerateWeekdayDates(
  start: Date,
  end: Date,
  weekdays: number[]
): Date[] {
  const set = new Set(weekdays);
  const out: Date[] = [];
  for (
    let d = new Date(start);
    isBefore(d, end) || isEqual(d, end);
    d = addDays(d, 1)
  ) {
    if (set.has(weekdayOf(d))) out.push(new Date(d));
  }
  return out;
}
