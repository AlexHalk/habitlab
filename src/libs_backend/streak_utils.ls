const {
  get_duolingo_streak
} = require('libs_backend/duolingo_utils')

export get_streak = (goal_name) ->>
  if goal_name == 'duolingo/complete_lesson_each_day'
    return await get_duolingo_streak()
  else
    target = await goal_utils.get_goal_target(goal_name)
    streak = 0
    streak_continuing = true
    console.log await get_visits_to_domain_days_before_today goal_info.domain, 0
    while streak_continuing
      progress_info = await get_progress_on_goal_days_before_today goal_name, streak
      if goal_info.is_positive == (progress_info.progress > target)
        streak += 1
      else
        streak_continuing = false
    return streak
    
  /*streak = await getvar_goal_unsynced_backend goal_name, "streak"
  if !(streak?)
    setvar_goal_unsynced_backend goal_name, "streak", 0
  return streak
  */

  
