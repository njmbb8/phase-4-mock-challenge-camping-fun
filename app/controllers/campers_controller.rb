class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response 

    def index
        render json: Camper.all, each_serializer: CamperIndexSerializer
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, include: :activities
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    private

    def camper_params
        params.permit(:name, :age)
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors[:name] }, status: :unprocessable_entity
    end

    def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
    end
end
