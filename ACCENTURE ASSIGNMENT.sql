CREATE DATABASE ACCENTURE

/*1*/
select TEACHER_ID,COUNT(TEACHER_ID) AS NO__OF_CLASSES FROM TEACHER_ALLOCATION
GROUP BY TEACHER_ID
ORDER BY TEACHER_ID ASC


/*2*/
SELECT COUNT(STUDENT_NAME),CLASS_ID FROM STUDENT
WHERE STUDENT_NAME="JOHN"
GROUP BY CLASS_ID


/*3*/
 SELECT STUDENT_ID,STUDENT_NAME,CLASS_ID,GENDER,DOB,ROW_NUMBER() OVER (PARTITION BY CLASS_ID ORDER BY STUDENT_NAME ASC ) AS ROLL_NUMBER
FROM STUDENT


/*4*/ SELECT GENDER,COUNT(STUDENT_ID) AS MALE_AND_FEMALE_RATIO FROM STUDENT
GROUP BY GENDER

/*5*/ SELECT TEACHER_NAME,TIMESTAMPDIFF(MONTH,DATE_OF_JOININGS,CURRENT_DATE()) DIV 12 AS YEARS,TIMESTAMPDIFF(MONTH,DATE_OF_JOININGS,CURRENT_DATE()) MOD 12 AS MONTHS
 FROM TEACHER
 
/*6*/ select stu.student_id,stu.student_name,stu.class_id,exa.exam_name,exa.exam_subject,paper.marks,exa.total_marks
from student stu
join
exam_paper paper on stu.student_id=paper.student_id
join
exam exa on paper.exam_id=exa.exam_id
order by stu.student_name asc

 select * from (
/*7*/ select  stu.student_id,stu.student_name,stu.class_id,sum(paper.marks) over 
(partition by stu.student_name order by stu.student_name asc)as STUDENT_QUARTERLY_MARKS,sum(exa.total_marks) over 
(partition by stu.student_name order by stu.student_name asc)AS TOTAL_QUARTERLY_MARKS,ROUND((sum(paper.marks) over 
(partition by stu.student_name order by stu.student_name asc) / Sum(exa.total_marks) over 
(partition by stu.student_name order by stu.student_name asc))*100,2) AS PERCENTAGE_OF_QUARTERLY_MARKS
from student stu
join
exam_paper paper on stu.student_id=paper.student_id
join
exam exa on paper.exam_id=exa.exam_id 
where stu.student_id in('1','4','9','16','25') and  exa.exam_name="quarterly") as temptable
group by student_name
ORDER BY STUDENT_ID ASC


/*8*/SELECT STUDENT_ID,STUDENT_NAME,CLASS_ID,EXAM_NAME,STUDENT_HALF_YEARLY_MARKS,RANK() OVER ( ORDER BY STUDENT_HALF_YEARLY_MARKS DESC) AS STUDENT_RANK FROM(
  select stu.student_id,stu.student_name,stu.class_id,exa.exam_name,sum(paper.marks) over 
(partition by stu.student_name order by stu.student_name asc)as STUDENT_HALF_YEARLY_MARKS
from student stu
join
exam_paper paper on stu.student_id=paper.student_id
join
exam exa on paper.exam_id=exa.exam_id
WHERE exa.exam_namE="HALF YEARLY"
) AS TEMPTABLE
GROUP BY STUDENT_NAME


