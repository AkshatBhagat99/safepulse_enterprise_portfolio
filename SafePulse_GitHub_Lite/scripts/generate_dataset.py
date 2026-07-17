out=BASE/'data/full_dataset_csv'
# Write reference tables
def write_csv(name, header, rows):
    with open(out/name, 'w', newline='', encoding='utf-8') as f:
        w=csv.writer(f)
        w.writerow(header)
        w.writerows(rows)

write_csv('district.csv',['district_id','district_name','state_code','created_at'],[(1,'SafePulse Unified School District','NJ','2025-07-01 08:00:00')])
write_csv('schools.csv',['school_id','district_id','school_name','region','school_level','active_flag'],[(i,1,n,r,l,True) for i,n,r,l in schools])
write_csv('departments.csv',['department_id','department_name','active_flag'],[(i+1,d,True) for i,d in enumerate(departments)])
terms=[]
start=datetime(2024,8,15)
for i in range(1,9):
    s=start+timedelta(days=90*(i-1))
    e=s+timedelta(days=89)
    terms.append((i,f"Term {i} {s.year}",s.date(),e.date()))
write_csv('academic_terms.csv',['term_id','term_name','start_date','end_date'],terms)
write_csv('case_categories.csv',['category_id','category_name','category_group','active_flag'],[(i+1,c, random.choice(['Safety','Peer & Social','Wellness','Parent/Family','Academic/Attendance']), True) for i,c in enumerate(categories)])
roles=['District Executive','Principal','Operations Director','Counseling Director','Support Coordinator','Counselor','BI Analyst','IT Security Admin']
perms=['view_all_schools','view_own_school','view_assigned_cases','create_case','assign_case','escalate_case','close_case','export_reports','admin_users','view_audit_logs']
write_csv('roles.csv',['role_id','role_name'],[(i+1,r) for i,r in enumerate(roles)])
write_csv('permissions.csv',['permission_id','permission_name'],[(i+1,p) for i,p in enumerate(perms)])
rp=[]
for rid in range(1,len(roles)+1):
    for pid in range(1,len(perms)+1):
        if rid in [1,3,4,7,8] or random.random()<0.45: rp.append((rid,pid))
write_csv('role_permissions.csv',['role_id','permission_id'],rp)
# users and counselors
users=[]; user_roles=[]; counselors=[]
first=['Alex','Jordan','Taylor','Morgan','Casey','Riley','Avery','Parker','Quinn','Skyler','Cameron','Drew','Jamie','Hayden','Reese']
last=['Brown','Patel','Garcia','Wilson','Chen','Singh','Rodriguez','Kim','Miller','Davis','Nguyen','Thomas','Lee','Martin','Clark']
for uid in range(1,401):
    school_id=random.choice(schools)[0] if uid>40 else None
    dept_id=random.randint(1,len(departments))
    name=f"{random.choice(first)} {random.choice(last)} {uid}"
    users.append((uid, school_id, dept_id, name, f"user{uid}@safepulse.edu", True))
    role_id=random.choices(range(1,len(roles)+1), weights=[2,8,3,3,10,28,4,2])[0]
    user_roles.append((uid,role_id))
    if role_id==6 or uid <= 180:
        counselors.append((len(counselors)+1, uid, random.randint(25,45), random.choice(['General Support','Peer Conflict','Family Engagement','Academic Stress','Safety Coordination'])))
write_csv('users.csv',['user_id','school_id','department_id','display_name','email','active_flag'],users)
write_csv('user_roles.csv',['user_id','role_id'],user_roles)
write_csv('counselors.csv',['counselor_id','user_id','max_active_cases','specialty'],counselors[:220])
# students
students=[]
for sid in range(1,25001):
    sch=random.choice(schools)[0]
    grade=random.choice(['K-2','3-5','6-8','9-12'])
    students.append((sid,sch,grade,f"ANON-{sid:06d}-{random.randint(1000,9999)}",True))
write_csv('students_anonymized.csv',['student_id','school_id','grade_band','anonymized_student_key','active_flag'],students)
# sla policy
sla=[]; pid=1
for pr in priorities:
    for cid in range(1,len(categories)+1):
        response={'Critical':4,'High':8,'Medium':16,'Low':24}[pr]
        resolution={'Critical':3,'High':7,'Medium':14,'Low':21}[pr]
        sla.append((pid, pr, cid, response, resolution, True)); pid+=1
write_csv('sla_policy.csv',['sla_policy_id','priority','category_id','response_due_hours','resolution_due_days','active_flag'],sla)
# holidays
holidays=[]
for year in [2024,2025,2026]:
    for m,d,n in [(1,1,'New Year'),(1,15,'MLK Day'),(2,19,'Presidents Day'),(5,27,'Memorial Day'),(7,4,'Independence Day'),(9,2,'Labor Day'),(11,28,'Thanksgiving'),(12,25,'Winter Holiday')]:
        try: holidays.append((datetime(year,m,d).date(),n,1))
        except: pass
write_csv('holiday_calendar.csv',['holiday_date','holiday_name','district_id'],holidays)
# requests and children
N=70000
support=[]; assignments=[]; status_hist=[]; notes=[]; followups=[]; escalations=[]; interventions=[]; notifications=[]; audits=[]
request_ids=list(range(1000001,1000001+N))
start_date=datetime(2024,8,15,8,0,0); end_date=datetime(2026,6,30,17,0,0)
delta=(end_date-start_date).days
counselor_user_ids=[c[1] for c in counselors[:220]]
for idx,rid in enumerate(request_ids,1):
    school_id=random.choice(schools)[0]
    student_id=random.randint(1,25000) if random.random()<0.82 else None
    cat_id=random.randint(1,len(categories))
    submitted=start_date+timedelta(days=random.randint(0,delta), hours=random.randint(0,8), minutes=random.randint(0,59))
    term_id=min(8, max(1, int(((submitted-start_date).days)//90)+1))
    priority=random.choices(priorities, weights=[35,42,18,5])[0]
    status=random.choices(statuses, weights=[3,4,8,20,8,5,6,24,20,2])[0]
    sla_id=[s[0] for s in sla if s[1]==priority and s[2]==cat_id][0]
    response_due={'Critical':4,'High':8,'Medium':16,'Low':24}[priority]
    resp_delay=random.randint(1, response_due*2)
    first_response=submitted+timedelta(hours=resp_delay) if status not in ['New','Triaged'] or random.random()<0.55 else ''
    resolved=''; closed=''
    if status in ['Resolved','Closed']:
        resolved=submitted+timedelta(days=random.randint(1,30), hours=random.randint(0,8))
        if status=='Closed': closed=resolved+timedelta(days=random.randint(0,5))
    reopened=random.random()<0.06
    support.append((rid,school_id,student_id,cat_id,term_id,priority,random.choice(channels),status,submitted,first_response,resolved,closed,reopened,sla_id))
    assigned_user=random.choice(counselor_user_ids)
# Full generator logic included in build script used to create this package.
