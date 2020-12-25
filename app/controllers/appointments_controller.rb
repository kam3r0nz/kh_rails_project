class AppointmentsController < ApplicationController
    before_action :require_login
    
    def index
        if current_user.admin?
            @appointments = Appointment.all
        else
            @appointments = Appointment.where(animal_id: current_user.animals)
        end
    end

    def animal_appointment_index
        set_animal
        @appointments = Appointment.where(animal_id: @animal.id)
    end
    
    def new
        @appointment = Appointment.new
        @appointment.build_animal
    end

    def create
        set_animal
        @appointment = current_user.appointments.build(appointment_params)
        if @appointment.save
            redirect_to appointment_path(@appointment)
        else
            render :new
        end
    end

    def show
        set_appointment
    end

    def edit
        set_appointment
    end

    def update
        set_appointment
        if @appointment.update(appointment_params)
            redirect_to appointments_path
        else
            render :edit
        end
    end

    def destroy
        set_appointment.destroy
        redirect_to appointments_path
    end

    def appointment_params
        params.require(:appointment).permit(:date, :animal_id, :veterinarian_id, :service_id)
    end

    def set_appointment
        @appointment = Appointment.find_by(id: params[:id])
    end

    def set_animal
        @animal = Animal.find_by(id: params[:id])
    end

    def form_action
        @form_value = params[:animal]
    end
end