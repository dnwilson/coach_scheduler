# CoachScheduler
CoachScheduler allow coaches to schedule and conduct appointments with students

## Features
[] As a Coach, I can add slots of availability to my calendar
  - Slots are always 2 hours long and can only be booked by 1 student
  - Slots must be in the future
  - Slots must be unique by datetime & coach (a Coach can't have multiple slots at the same time)
[] As a Coach, I can view their own upcoming schedule.
[] As a Student, I can view upcoming available times across all coaches
[] As a Student, I can book a slot for a call (the full 2 hours)
[] As a Coach, I can record a student's satisfaction (integer 1- 5) and write some notes
[] As a Coach, I shoudl be able to review past scores and notes for all of my calls


## Data Model
Coach
  - name
  - image

Student
  - name
  - image

Slot
  - coach_id (fk)
  - start_at
  - end_at

Appointment
  - student_id (fk)
  - slot_id (fk)
  - satisfaction
  - notes
