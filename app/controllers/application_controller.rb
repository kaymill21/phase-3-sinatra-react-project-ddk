class ApplicationController < Sinatra::Base
  set :default_content_type, "application/json"


  # Appointment routes
  get "/appointments" do
    appointments = Appointment.all.order(:created_at).reverse_order
    # appointments.to_json(include: [{ doctor: { only: [:doctor_lastname] } }, { patient: { only: [:patient_lastname] } }])
    # appointments.to_json(include: [:doctor, :patient])
    appointments.to_json
  end

  get "/appointments/:id" do
    appointment = Appointment.find(params[:id])
    appointment.to_json(include: [:doctor, :patient])
  end

  post "/appointments" do
    appointment = Appointment.create(
      appointment_date: params[:appointment_date],
      appointment_duration: params[:appointment_duration],
      appointment_reason: params[:appointment_reason],
      appointment_type: params[:appointment_type],
      appointment_doctor: params[:appointment_doctor],
      appointment_patient: params[:appointment_patient],
      doctor_id: params[:doctor_id],
      patient_id: params[:patient_id],
    )
    appointment.to_json
  end

  patch "/appointments/:id" do
    appointment = Appointment.find(params[:id])
    appointment.update(
      appointment_date: params[:appointment_date],
      appointment_duration: params[:appointment_duration],
      appointment_reason: params[:appointment_reason],
      appointment_type: params[:appointment_type],
      # appointment_doctor: params[:appointment_doctor],
      # appointment_patient: params[:appointment_patient],
    )
    appointment.to_json
  end

  delete "/appointments/:id" do
    appointment = Appointment.find(params[:id])
    appointment.destroy
    appointment.to_json
  end

  # Doctor routes
  get "/doctors" do
    doctors = Doctor.all
    doctors.to_json
  end

  post "/doctors" do
    doctor = Doctor.create(
      doctor_firstname: params[:doctor_firstname],
      doctor_lastname: params[:doctor_lastname],
      doctor_phone: params[:doctor_phone],
      doctor_email: params[:doctor_email],
    )
    doctor.to_json
  end

  get "/doctors/:doctor_id" do
    doctor = Doctor.find(params[:doctor_id])
    doctor.to_json
  end

  # This is magic
  get "/doctors/search/:doctor_lastname" do
    doctor = Doctor.where("doctor_lastname=?", params[:doctor_lastname])
    doctor.to_json
  end

  get "/doctors/:doctor_id/appointments" do
    doctor = Doctor.find(params[:doctor_id])
    doctor_appointments = doctor.appointments.uniq
    doctor_appointments.to_json
  end

  get "/doctors/:doctor_id/patients" do
    doctor = Doctor.find(params[:doctor_id])
    doctor_patients = doctor.patients.uniq
    doctor_patients.to_json
  end

  patch "/doctors/:doctor_id" do
    doctor = Doctor.find(params[:doctor_id])
    doctor.update(
      doctor_firstname: params[:doctor_firstname],
      doctor_phone: params[:doctor_phone],
      doctor_email: params[:doctor_email],
    )
    doctor.to_json
  end

  delete "/doctors/:id" do
    doctor = Doctor.find(params[:id])
    doctor.destroy
    doctor.to_json
  end

  # Patient routes
  get "/patients" do
    patients = Patient.all
    patients.to_json
  end

  post "/patients" do
    patient = Patient.create(
      patient_firstname: params[:patient_firstname],
      patient_lastname: params[:patient_lastname],
      patient_address: params[:patient_address],
      patient_city: params[:patient_city],
      patient_state: params[:patient_state],
      patient_phone: params[:patient_phone],
      patient_email: params[:patient_email],
    )
    patient.to_json
  end

  get "/patients/:patient_id" do
    patient = Patient.find(params[:patient_id])
    patient.to_json
  end

  get "/patients/:patient_id/appointments" do
    patient = Patient.find(params[:patient_id])
    patient_appointments = patient.appointments.uniq
    patient_appointments.to_json
  end

  get "/patients/:patient_id/doctors" do
    patient = Patient.find(params[:patient_id])
    patient_doctors = patient.doctors.uniq
    patient_doctors.to_json
  end

  patch "/patients/:patient_id" do
    patient = Patient.find(params[:patient_id])
    patient.update(
      patient_firstname: params[:patient_firstname],
      # patient_lastname: params[:patient_lastname],
      patient_address: params[:patient_address],
      patient_city: params[:patient_city],
      patient_state: params[:patient_state],
      patient_phone: params[:patient_phone],
      patient_email: params[:patient_email],
    )
    patient.to_json
  end

  delete "/patients/:id" do
    patient = Patient.find(params[:id])
    patient.destroy
    patient.to_json
  end
end