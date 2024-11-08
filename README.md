# QR Code Attendance Logger
This project is aimed at solving the common problem of students signing attendance sheets at universities for lectures they have missed.  

This issue is usually a nuisance for lecturers and faculty to deal with, and it is an important problem that needs to be solved. The solution for this: QR codes.

## Background Case Study
In my university, and probably in a lot others, attendance for lectures is taken by signing an attendance sheet at some point in the lecture. This attendance is recorded in a datable, and sometimes it is used as a threshold to determine if a student can sit the final exam; meaning that the student should have attended <b>66%</b> of their classes to be eligible to sit the final exam for a unit.

Due to this constraint, some students may skip class but request that someone else who is present copy their signature and sign their attendance for them, which ends up getting recorded into the database if not detected. This is problematic for the school faculty and can cause issues when the attendance records may need to be used, for example in a legal case.

## Proposed Solution
Almost all students in university carry some form of mobile device which has an accessible camera and internet connection, which means they can make use of a QR code to scan and sign their attendance.

To ensure that a student is actually present, the application developed will do the following:  
1. Make sure the student is logged in to the application using their ID and password, and can only switch accounts within an interval of 15 minutes to an hour as to prevent students from sharing passwords to sign attendance,
2. Generating unique QR codes for each lecture, which will prevent students from forging their own QR codes to sign the attendance,
3. Location tracking: in order to prevent a student from scanning the QR code when outside the university campus, a GPS location check will be done to make sure that the student is within a certain distance of the university, ensuring they can only scan the QR code when in the lecture.

## Advantages Provided
- Lecturers no longer have to manually go through a paper attendance sheet and record the data into the database, the application can automatically fill in the database in real time,
- Smaller possibility of errors or discrepancies in the attendance data,
- Higher student attendance rates as this method forces students to attend the lecture in order to sign the attendance, students can no longer sign for one another,

## Possible Problems And Solutions
- Some students may not have a mobile device or internet connection, although this may be for a handful of students a fall back would be to continue using the attendance sheet to sign, but only for students who do not have the means to use the application.
