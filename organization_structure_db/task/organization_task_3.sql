select 
	e.employeeid as "EmployeeID"
	, e.name as "EmployeeName"
	, e.managerid as "ManagerID"
	, d.departmentname as "DepartmentName"
	, r.rolename as "RoleName"
	, string_agg(distinct p.projectname, ',') as "ProjectNames" 
	, string_agg(distinct t.taskname, ',' order by t.taskname desc) as "TaskNames"
	, count(distinct sub.employeeid) as "TotalSubordinates"
from employees e 
join employees sub
	on e.employeeid = sub.managerid
join roles r 
	on r.roleid = e.roleid
join departments d 
	on d.departmentid = e.departmentid
join tasks t 
	on t.assignedto = e.employeeid
join projects p
	on p.projectid = t.projectid
where r.rolename = 'Менеджер'
group by e.employeeid, e.name, d.departmentname, r.rolename