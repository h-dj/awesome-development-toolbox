- http://blog.csdn.net/qaz13177_58_/article/details/5575711/

#### 一、DDL语句
```
DROP TABLE IF EXISTS `STUDENT`;

CREATE TABLE STUDENT (
	ID INT auto_increment NOT NULL,
	SNO varchar(8) NOT NULL COMMENT '学号',
	SNAME varchar(4) NULL COMMENT '学生名称',
	SSEX varchar(2) NULL COMMENT '性别',
	SBIRTHDAY DATETIME NULL COMMENT '生日',
	CLASS varchar(5) NULL COMMENT '班级',
	CONSTRAINT STUDENT_pk PRIMARY KEY (ID),
	CONSTRAINT STUDENT_un UNIQUE KEY (SNO)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci
COMMENT='学生表';


DROP TABLE IF EXISTS `COURSE`;

CREATE TABLE COURSE (
	ID INT auto_increment NOT NULL,
	CNO VARCHAR(5) NOT NULL COMMENT '课程号',
	CNAME varchar(104) NULL COMMENT '课程名称',
	TNO VARCHAR(10) NULL COMMENT '老师编号',
	CONSTRAINT COURSE_pk PRIMARY KEY (ID),
	CONSTRAINT COURSE_un UNIQUE KEY (CNO)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci
COMMENT='课程表';


DROP TABLE IF EXISTS `SCORE`;

CREATE TABLE SCORE (
	ID INT auto_increment NOT NULL,
	SNO VARCHAR(8) NOT NULL COMMENT '学生号',
	CNO VARCHAR(8) NULL COMMENT '课程号',
	`DEGREE` decimal(4,1) NULL COMMENT '成绩',
	CONSTRAINT SCORE_pk PRIMARY KEY (ID),
	CONSTRAINT SCORE_un UNIQUE KEY (SNO,CNO)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci
COMMENT='成绩表';

DROP TABLE IF EXISTS `TEACHER`;

CREATE TABLE TEACHER (
	ID INT auto_increment NOT NULL,
	TNO VARCHAR(8) NOT NULL COMMENT '老师编码',
	TNAME VARCHAR(4) NOT NULL COMMENT '老师名称',
	TSEX VARCHAR(2) NOT NULL COMMENT '老师性别',
	TBIRTHDAY DATETIME NULL COMMENT '老师生日',
	PROF VARCHAR(6) COMMENT '职称',
	DEPART VARCHAR(10) NOT NULL COMMENT '部门',
	CONSTRAINT TEACHER_pk PRIMARY KEY (ID),
	CONSTRAINT TEACHER_un UNIQUE KEY (TNO)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci
COMMENT='老师表';


DROP TABLE IF EXISTS `GRADE`;

CREATE TABLE GRADE (
	ID INT auto_increment NOT NULL,
	`low` decimal(4,1) DEFAULT null COMMENT '下限',
	  `upp` decimal(4,1) DEFAULT null COMMENT '上限',
	  `rank` char(1) DEFAULT null COMMENT '排名',
	CONSTRAINT GRADE_pk PRIMARY KEY (ID)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci
COMMENT='排名';


INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES (108 ,'曾华' 
,'男' ,'1977-09-01',95033);
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES (105 ,'匡明' 
,'男' ,'1975-10-02',95031);
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES (107 ,'王丽' 
,'女' ,'1976-01-23',95033);
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES (101 ,'李军' 
,'男' ,'1976-02-20',95033);
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES (109 ,'王芳' 
,'女' ,'1975-02-10',95031);
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES (103 ,'陆君' 
,'男' ,'1974-06-03',95031);

INSERT INTO COURSE(CNO,CNAME,TNO)VALUES ('3-105' ,'计算机导论',825);
INSERT INTO COURSE(CNO,CNAME,TNO)VALUES ('3-245' ,'操作系统' ,804);
INSERT INTO COURSE(CNO,CNAME,TNO)VALUES ('6-166' ,'数据电路' ,856);
INSERT INTO COURSE(CNO,CNAME,TNO)VALUES ('9-888' ,'高等数学' ,100);

INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (103,'3-245',86);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (105,'3-245',75);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (109,'3-245',68);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (103,'3-105',92);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (105,'3-105',88);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (109,'3-105',76);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (101,'3-105',64);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (107,'3-105',91);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (108,'3-105',78);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (101,'6-166',85);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (107,'6-106',79);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (108,'6-166',81);

INSERT INTO TEACHER(TNO,TNAME,TSEX,TBIRTHDAY,PROF,DEPART) 
VALUES (804,'李诚','男','1958-12-02','副教授','计算机系');
INSERT INTO TEACHER(TNO,TNAME,TSEX,TBIRTHDAY,PROF,DEPART) 
VALUES (856,'张旭','男','1969-03-12','讲师','电子工程系');
INSERT INTO TEACHER(TNO,TNAME,TSEX,TBIRTHDAY,PROF,DEPART)
VALUES (825,'王萍','女','1972-05-05','助教','计算机系');
INSERT INTO TEACHER(TNO,TNAME,TSEX,TBIRTHDAY,PROF,DEPART) 
VALUES (831,'刘冰','女','1977-08-14','助教','电子工程系');



-- ----------------------------
-- Records of grade
-- ----------------------------
INSERT INTO `grade`(low,upp,`rank`) VALUES (90, 100, 'A');
INSERT INTO `grade`(low,upp,`rank`) VALUES (80, 89, 'B');
INSERT INTO `grade`(low,upp,`rank`) VALUES (70, 79, 'C');
INSERT INTO `grade`(low,upp,`rank`) VALUES (60, 69, 'D');
INSERT INTO `grade`(low,upp,`rank`) VALUES (0, 59, 'E');

```

#### 练习题
题目：
- 1、 查询Student表中的所有记录的Sname、Ssex和Class列。
- 2、 查询教师所有的单位即不重复的Depart列。
- 3、 查询Student表的所有记录。
- 4、 查询Score表中成绩在60到80之间的所有记录。
- 5、 查询Score表中成绩为85，86或88的记录。
- 6、 查询Student表中“95031”班或性别为“女”的同学记录。
- 7、 以Class降序查询Student表的所有记录。
- 8、 以Cno升序、Degree降序查询Score表的所有记录。
- 9、 查询“95031”班的学生人数。
- 10、查询Score表中的最高分的学生学号和课程号。
- 11、查询‘3-105’号课程的平均分。
- 12、查询Score表中至少有5名学生选修的并以3开头的课程的平均分数。
- 13、查询最低分大于70，最高分小于90的Sno列。
- 14、查询所有学生的Sname、Cno和Degree列。
- 15、查询所有学生的Sno、Cname和Degree列。
- 16、查询所有学生的Sname、Cname和Degree列。
- 17、查询“95033”班所选课程的平均分。
- 18、假设使用如下命令建立了一个grade表：
- 19、查询选修“3-105”课程的成绩高于“109”号同学成绩的所有同学的记录。
- 20、查询score中选学一门以上课程的同学中分数为非最高分成绩的记录。
- 21、查询成绩高于学号为“109”、课程号为“3-105”的成绩的所有记录。
- 22、查询和学号为108的同学同年出生的所有学生的Sno、Sname和Sbirthday列。
- 23、查询“张旭“教师任课的学生成绩。
- 24、查询选修某课程的同学人数多于5人的教师姓名。
- 25、查询95033班和95031班全体学生的记录。
- 26、查询存在有85分以上成绩的课程Cno.
- 27、查询出“计算机系“教师所教课程的成绩表。
- 28、查询“计算机系”与“电子工程系“不同职称的教师的Tname和Prof。
- 29、查询选修编号为“3-105“课程且成绩至少高于选修编号为“3-245”的同学的Cno、Sno和Degree,并按Degree从高到低次序排序。
- 30、查询选修编号为“3-105”且成绩高于选修编号为“3-245”课程的同学的Cno、Sno和Degree.
- 31、查询所有教师和同学的name、sex和birthday.
- 32、查询所有“女”教师和“女”同学的name、sex和birthday.
- 33、查询成绩比该课程平均成绩低的同学的成绩表。
- 34、查询所有任课教师的Tname和Depart.
- 35  查询所有未讲课的教师的Tname和Depart. 
- 36、查询至少有2名男生的班号。
- 37、查询Student表中不姓“王”的同学记录。
- 38、查询Student表中每个学生的姓名和年龄。
- 39、查询Student表中最大和最小的Sbirthday日期值。
- 40、以班号和年龄从大到小的顺序查询Student表中的全部记录。
- 41、查询“男”教师及其所上的课程。
- 42、查询最高分同学的Sno、Cno和Degree列。
- 43、查询和“李军”同性别的所有同学的Sname.
- 44、查询和“李军”同性别并同班的同学Sname.
- 45、查询所有选修“计算机导论”课程的“男”同学的成绩表


1.查询Student表中的所有记录的Sname、Ssex和Class列。
```
SELECT
	sname,
	ssex,
	class
FROM
	student
```

2. 查询教师所有的单位即不重复的Depart列。
```
SELECT DISTINCT
	depart
FROM
	teacher
```
3.  查询Student表的所有记录。
```
SELECT
	*
FROM
	student
```

4.  查询Score表中成绩在60到80之间的所有记录。
```
SELECT
	*
FROM
	score
WHERE
	DEGREE BETWEEN 60 AND 80  
	--或者DEGREE > 60 AND DEGREE<80
```
5. 查询Score表中成绩为85，86或88的记录。
```
SELECT
	*
FROM
	score
WHERE
	DEGREE in (85,86,88)
```
6. 查询Student表中“95031”班或性别为“女”的同学记录。
```
SELECT * FROM student
WHERE CLASS = '95031' OR SSEX = '女'
```

7.  以Class降序查询Student表的所有记录。
```
SELECT * FROM student
ORDER BY CLASS DESC   --desc为降序， ASC为升序

```

8. 以Cno升序、Degree降序查询Score表的所有记录。
```
SELECT * FROM score
ORDER BY CNO ASC ,DEGREE DESC
```
9.  查询“95031”班的学生人数。
```
SELECT COUNT(*) as '95031人数'
FROM student
WHERE CLASS ='95031'
```

10. 查询Score表中的最高分的学生学号和课程号。
```
SELECT sno as '学生号',cno as '课程号'
FROM score 
WHERE DEGREE = (SELECT MAX(DEGREE) FROM score)
```
11. 查询‘3-105’号课程的平均分。
```
SELECT AVG(DEGREE) as '3-105’号课程的平均分'
FROM score
WHERE CNO = '3-105'
```

12. 查询Score表中至少有5名学生选修的并以3开头的课程的平均分数。
```
SELECT AVG(DEGREE) ,CNO
FROM score 
GROUP BY CNO
HAVING CNO LIKE '3%' AND COUNT(SNO) >= 5
```

13. 查询最低分大于70，最高分小于90的Sno列。
```
SELECT sno
FROM score
GROUP BY SNO
HAVING MAX(DEGREE) <=90 AND MIN(DEGREE)>=70
```
14. 查询所有学生的Sname、Cno和Degree列。
```
SELECT
	A.SNAME,
	B.CNO,
	B.DEGREE
FROM
	STUDENT AS A
INNER JOIN SCORE AS B ON A.SNO = B.SNO;
```
15. 查询所有学生的Sno、Cname和Degree列。
```
SELECT
	A.CNAME,
	B.SNO,
	B.DEGREE
FROM
	course AS A
INNER JOIN SCORE AS B ON A.CNO = B.CNO;
```

16. 查询所有学生的Sname、Cname和Degree列。
```
SELECT
	A.SNAME,
	B.CNAME,
	C.DEGREE
FROM
	STUDENT A
JOIN (COURSE B, SCORE C) ON A.SNO = C.SNO
AND B.CNO = C.CNO;
```

17. 查询“95033”班所选课程的平均分。
```
SELECT AVG(DEGREE) 
FROM score a1
INNER JOIN student a2 on a1.sno = a2.SNO
WHERE a2.CLASS = '95033' 
```

18. 现查询所有同学的Sno、Cno和rank列。
```
-- 多表查询
SELECT a1.sno,a1.cno,a2.rank FROM
score a1, grade a2
WHERE a1.DEGREE BETWEEN a2.low AND a2.upp

```

19. 查询选修“3-105”课程的成绩高于“109”号同学成绩的所有同学的成绩记录。
```
SELECT a1.*,a2.*
FROM score a1 JOIN score a2 -- 内链接
WHERE a1.CNO = '3-105' 
AND a1.DEGREE>a2.DEGREE 
AND a2.SNO='109' AND a2.CNO='3-105';
```

20. 查询score中选学一门以上课程的同学中分数为非最高分成绩的记录。
```
SELECT
	*
FROM
	score s
WHERE
	DEGREE < (SELECT MAX(DEGREE) FROM SCORE)
GROUP BY
	SNO
HAVING
	COUNT(SNO) > 1
ORDER BY
	DEGREE;
```
21. 查询成绩高于学号为“109”、课程号为“3-105”的成绩的所有记录。
```
-- any表示有任何一个满足就返回true，all表示全部都满足才返回true 
SELECT
	A.*
FROM
	SCORE A
WHERE A.DEGREE > ALL (
	SELECT
		DEGREE
	FROM
		SCORE B
	WHERE
		B.SNO = '109'
	AND B.CNO = '3-105'
);
```

22. 查询和学号为108的同学同年出生的所有学生的Sno、Sname和Sbirthday列。
```
-- YEAR() 分析日期值，返回关于年份的部分
SELECT * 
FROM student
WHERE YEAR(SBIRTHDAY) = (SELECT YEAR(SBIRTHDAY) FROM student WHERE SNO = 108)
AND SNO != 108

```

23. 查询“张旭“教师任课的学生成绩。
```
select *
from SCORE
where CNO in (
    select CNO
    from COURSE
    where TNO = (select TNO
                 from TEACHER
                 where TNAME = '张旭')
);

select cno, sno, degree
from score
where cno = (select x.cno
             from course x,
                  teacher y
             where x.tno = y.tno
               and y.tname = '张旭');
               
               
```
24.查询选修某课程的同学人数多于5人的教师姓名。

```
SELECT Tname
FROM teacher
WHERE Tno IN( SELECT Tno
              FROM course
              WHERE Cno IN( SELECT Cno
                            FROM score
                            GROUP BY Cno
                            HAVING COUNT(Cno)>5))

select teacher.TNAME from teacher
inner join course on course.TNO = teacher.TNO
where CNO in (
    select CNO
    from score
    group by CNO
    having count(*) > 5
);
```
25. 查询95033班和95031班全体学生的记录。

```
SELECT *
FROM student
         LEFT JOIN score
                   ON student.sno = score.sno
WHERE student.class IN ('95033','95031')
```
26. 查询存在有85分以上成绩的课程Cno.

```
select distinct CNO from score
where DEGREE >=85
```
27. 查询出“计算机系“教师所教课程的成绩表。

```
select sno, cno, degree
from score
where CNO in (
    select CNO
    from teacher
             inner join course on course.TNO = teacher.TNO
    where DEPART = '计算机系'
)

SELECT sno, cno, degree
FROM score
WHERE cno IN (SELECT cno
              FROM course a
                       JOIN (SELECT tno FROM teacher WHERE depart = '计算机系') b
                            ON a.tno = b.tno)

SELECT sno, cno, degree
FROM score
WHERE cno IN (SELECT Cno
              FROM Course
              WHERE Tno IN (SELECT Tno FROM teacher WHERE depart = '计算机系'))
```
28.查询“计算机系”与“电子工程系“不同职称的教师的Tname和Prof。

```
SELECT Tname, prof
FROM teacher
WHERE prof NOT IN
      (SELECT prof
       FROM teacher
       WHERE Depart = '计算机系'
         AND prof IN
             (SELECT prof
              FROM teacher
              WHERE Depart = '电子工程系'
             ))


select Tname, prof
from teacher
where PROF in (
    SELECT prof
    FROM teacher
    WHERE depart = '计算机系'
       OR depart = '电子工程系'
    GROUP BY prof
    HAVING COUNT(prof) = 1
)
```
29. 查询选修编号为“3-105“课程且成绩至少高于选修编号为“3-245”的同学的Cno、Sno和Degree,并按Degree从高到低次序排序。

```
SELECT sno, cno, degree
FROM score
WHERE cno = '3-105'
  AND degree >= (SELECT MIN(degree) FROM score WHERE cno = '3-245')
order by DEGREE desc

```

30. 查询选修编号为“3-105”且成绩高于选修编号为“3-245”课程的同学的Cno、Sno和Degree.
```
SELECT sno, cno, degree
FROM score
WHERE cno = '3-105'
  AND degree > (SELECT MAX(degree) FROM score WHERE cno = '3-245')
```

31. 查询所有教师和同学的name、sex和birthday.

```
select TNAME as name,TSEX as sex,TBIRTHDAY as birthday from teacher
union
select SNAME as name,SSEX as sex,SBIRTHDAY as birthday from student
```

32.查询所有“女”教师和“女”同学的name、sex和birthday.

```
select *
from (
         select TNAME as name, TSEX as sex, TBIRTHDAY as birthday
         from teacher
         union
         select SNAME as name, SSEX as sex, SBIRTHDAY as birthday
         from student
     ) as t
where t.sex = '女'
```

33.查询成绩比该课程平均成绩低的同学的成绩表。

```
SELECT A.* FROM SCORE A WHERE DEGREE<(SELECT AVG(DEGREE) FROM SCORE B WHERE A.CNO=B.CNO);
```
34. 查询所有任课教师的Tname和Depart.

```
-- 1
select tname, depart
from teacher
         inner join course on course.tno = teacher.tno

-- 2
select tname, depart
from teacher a
where exists
          (select * from course b where a.tno = b.tno);

-- 3
SELECT TNAME,DEPART FROM TEACHER WHERE TNO IN (SELECT TNO FROM COURSE);
```
35. 

```
-- 1
select tname, depart
from teacher
         left join course on course.tno = teacher.tno
where isnull(course.tno);

-- 2
select tname, depart
from teacher a
where not exists
    (select * from course b where a.tno = b.tno);

-- 3
select tname, depart
from teacher
where tno not in (select tno from course);
```
36.查询至少有2名男生的班号。

```
SELECT CLASS FROM STUDENT A WHERE SSEX='男' GROUP BY CLASS HAVING COUNT(SSEX)>1;
```

37. 查询Student表中不姓“王”的同学记录。

```
select * from student
where SNAME not like '王%'
```
38. 查询Student表中每个学生的姓名和年龄。

```
select sname, timestampdiff(year, sbirthday, curdate()) from student

select sname,(year(now())-year(sbirthday)) as age from student;
```
39.查询Student表中最大和最小的Sbirthday日期值。

```
select sname, sbirthday as THEMAX
from student
where sbirthday = (select min(SBIRTHDAY)

                   from student)
union
select sname, sbirthday as THEMIN
from student
where sbirthday = (select max(SBIRTHDAY)
                   from student);
```

40.以班号和年龄从大到小的顺序查询Student表中的全部记录。

```
select class,timestampdiff(year, sbirthday, curdate()) as age
from student
order by class desc, age desc

select class, (year(now()) - year(sbirthday)) as age
from student
order by class desc, age
    desc;
```
41. 查询“男”教师及其所上的课程。

```
select *
from course
where TNO in (
    select TNO
    from teacher
    where TSEX = '男'
);

select course.*
from course
inner join teacher on course.tno = teacher.tno
where teacher.tsex = '男'
```
42. 查询最高分同学的Sno、Cno和Degree列。

```
select *
from score
where degree = (select max(degree) from score)
```
43.查询和“李军”同性别的所有同学的Sname.

```
select SNAME
from student
where SSEX = (
    select SSEX
    from student
    where SNAME = '李军'
)
```
44.查询和“李军”同性别并同班的同学Sname.

```
select t1.sname
from student t1
         inner join (select class, ssex
                     from student
                     where sname = '李军') as t2
                    on t1.class = t2.class and t1.ssex = t2.ssex


select sname
from student a
where ssex = (select ssex from student b where b.sname = '李军')
  and class = (select class from student c where c.sname = '李军');
```
45. 查询所有选修“计算机导论”课程的“男”同学的成绩表

```
select *
from student t1
         inner join score t2 on t1.SNO = t2.SNO
         inner join course t3 on t2.CNO = t3.CNO
where t1.SSEX = '男'
  and t3.CNAME = '计算机导论'

select *
from score
where sno in (select sno
              from student
              where ssex = '男')
  and cno = (select cno
             from course
             where cname = '计算机导论');
```
