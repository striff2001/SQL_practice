with recursive employee_hierarchy as (
	select *
	from employees e 
	where e.managerid = 1
	union all
	select e.*
	from employees e 
	join employee_hierarchy eh
		on eh.employeeid = e.managerid 
),
t as (
select 
	employeeid as "EmployeeID"
	, name as "EmployeeName"
	, managerid as "ManagerID"
	, d.departmentname as "DepartmentName"
	, r.rolename as "RoleName"
	, string_agg(distinct p.projectname, ',') as "ProjectNames" 
	, string_agg(distinct t.taskname, ',') as "TaskNames"
	, count(taskid) as "TotalTasks"
from employee_hierarchy e
left join departments d 
	on e.departmentid = d.departmentid
left join roles r 
	on r.roleid = e.roleid
left join tasks t 
	on t.assignedto = e.employeeid
left join projects p 
	on p.projectid = t.projectid
group by e.employeeid, e.name, e.managerid, d.departmentname, r.rolename
order by name
)
select t.*, count(distinct Subordinat."EmployeeID") as "TotalSubordinates"
from t
left join t Subordinat
	on t."EmployeeID" = Subordinat."ManagerID"
group by t."EmployeeID", t."EmployeeName", t."ManagerID", t."DepartmentName", t."RoleName", t."ProjectNames", t."TaskNames", t."TotalTasks"
order by t."EmployeeName"