--The following code can be used to automatically update patients table with newest appointments.
--This will be thrown into a for loop on python, if this code raises an excepetion,
--or in other words if this patient is in the system it will result move to an update query instead.
INSERT INTO Patients 
    (USERNAME, NAME, EMAIL, MEDS, LASTATTEND)
SELECT 
    PATIENTUNAME, 
    PATIENTFNAME || ' ' || PATIENTLNAME, 
    PATIENTEMAIL,
    PATIENTMEDS, 
    TO_CHAR(MAX(TO_DATE(APPOINTMENTDATE, 'MM/DD/YYYY')), 'MM/DD/YYYY') 
FROM 
    Appointments 
GROUP BY 
    PATIENTUNAME, PATIENTFNAME, PATIENTLNAME, PATIENTEMAIL, PATIENTMEDS;

--The following query is the update code(python) that will occur in case of a user already 
--existing in the table. With both of these queries complete, we can now automatically update 
--both tables when a new appointment is scheduled by users such as admins
UPDATE PATIENTS p
SET 
    LASTATTEND = (
        SELECT 
            TO_CHAR(MAX(TO_DATE(a.APPOINTMENTDATE, 'MM/DD/YYYY')), 'MM/DD/YYYY')
        FROM 
            Appointments a
        WHERE 
            a.PATIENTUNAME = p.USERNAME
    );
