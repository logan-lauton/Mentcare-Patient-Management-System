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
