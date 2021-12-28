class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response 

    def create
        signup = Signup.create!(signups_params)
        render json: signup.activity, status: :created
    end

    private

    def signups_params
        params.permit(:camper_id, :activity_id, :time)
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors[:name] }, status: :unprocessable_entity
    end
end
