/* Welcome to the SQL mini project. For this project, you will use
Springboard' online SQL platform, which you can log into through the
following link:

https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

Note that, if you need to, you can also download these tables locally.

In the mini project, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */



/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */

Ans:- 
Query:-
SELECT *
FROM Facilities
WHERE membercost!=0

Names:-Tennis court 1, Tennis court 2,Massage Room,Squash court



/* Q2: How many facilities do not charge a fee to members? */
Ans:Total 4 facilities
Query:-
SELECT *
FROM Facilities
WHERE membercost=0


/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */
Ans:
Query:-
SELECT facid, name, membercost, monthlymaintenance
FROM Facilities
WHERE membercost !=0
AND membercost < 0.2 * monthlymaintenance

/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */

Ans:-
Query:-
SELECT *
FROM Facilities
ORDER BY facid
LIMIT 5
/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */
Ans:-
Query:-
SELECT
     name
     ,monthlymaintenance
     ,if(monthlymaintenance > 100, 'Expensive','Cheap') AS budget
 FROM
      facilities


/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */
Query:-
SELECT
       f.name AS court
       ,concat(m.firstname,' ',m.surname) AS name
   FROM
      bookings b
   INNER JOIN
      (SELECT * FROM facilities WHERE facid IN ('0','1'))f
   ON (b.facid = f.facid)
   INNER JOIN
       members m
   ON (b.memid = m.memid)
   GROUP BY f.name, m.firstname, m.surname
   ORDER BY m.firstname

/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */
Query
SELECT
      b.bookid
      ,f.name AS facility
      ,concat(m.firstname,' ',m.surname) AS name
      ,SUM(if(b.memid = 0, f.guestcost*b.slots, f.membercost*b.slots)) as cost
  FROM
     bookings b
  INNER JOIN
     facilities f
  ON (b.facid = f.facid)
  INNER JOIN
      members m
  ON (b.memid = m.memid)
  WHERE 
      date(b.starttime) = '2012-09-14'
  GROUP BY 
      f.name,m.firstname,m.surname,b.bookid
  HAVING
      cost > 30
  ORDER BY
      cost desc

/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */
Query:-
SELECT
      b.bookid
      ,f.name AS facility
      ,concat(m.firstname,' ',m.surname) AS name
      ,SUM(if(b.memid = 0, f.guestcost*b.slots, f.membercost*b.slots)) as cost
  FROM
     bookings b
  INNER JOIN
     facilities f
  ON (b.facid = f.facid)
  INNER JOIN
      members m
  ON (b.memid = m.memid)
  WHERE 
      date(b.starttime) = '2012-09-14'
  GROUP BY 
      f.name,m.firstname,m.surname,b.bookid
  HAVING
      cost > 30
  ORDER BY
      cost desc

/* Q9: This time, produce the same result as in Q8, but using a subquery. */

Query:-
SELECT
       bookid
       ,facility
       ,name
       ,MAX(cost) as cost
   FROM
   (
       SELECT
          f.name AS facility
          ,concat(m.firstname,' ',m.surname) AS name
          ,if(b.memid = 0, f.guestcost*b.slots, f.membercost*b.slots) as cost
          ,b.bookid
      FROM
         bookings b
      INNER JOIN
         facilities f
      ON (b.facid = f.facid)
      INNER JOIN
          members m
      ON (b.memid = m.memid)
      WHERE 
          date(b.starttime) = '2012-09-14'
   )
   GROUP BY bookid,facility,name
   HAVING cost > 30
   ORDER BY cost desc
/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */
Query:-
SELECT
       facilityname
       ,SUM(if(memid = 0, guestcost*slots, membercost*slots)) as revenue
   FROM
   (
       SELECT 
           f.name as facilityname
           ,b.memid
           ,f.guestcost
           ,f.membercost
           ,b.slots
       FROM
           bookings b
       INNER JOIN
           facilities f
       ON (b.facid = f.facid) 
   )
   GROUP BY
       facilityname
       HAVING 
          revenue < 1000
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                