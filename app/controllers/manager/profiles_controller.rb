class Manager::ProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:create]

  layout 'form', only: [:create]
  def index
    @title = t('profiles_controller.title')
    @description = t('profiles_controller.description')

    @forms = current_user.forms

    @agencies = [[t('profiles_controller.without_agency'), 'no_agency']] + get_all_agencies.map { |agency| [agency, agency] }

    @boolean_options = [[t('profiles_controller.with'), true], [t('profiles_controller.without'), false]]

    query = FindProfiles.new(current_user).call(params).load_async
    @total_count = query.count
    @pagy, @profiles = pagy_countless(query, items: 24)
  end

  def create
    @form = Form.find_by(token: params[:token])
    @profile = @form.profiles.new(profile_params)


    @filtered_admited_form_fields = {}
    @filtered_featured_options = {}

    @form.ordered_fields.each do |key, value|
      if Form::ADMITED_FORM_FIELDS[key.to_sym]
        if value['include'] == 'true'
          @filtered_admited_form_fields[key.to_sym] = Form::ADMITED_FORM_FIELDS[key.to_sym]
        end
      end

      if Form::FEATURES_OPTIONS[key.to_sym]
        if value['include'] == 'true'
          @filtered_featured_options[key.to_sym] = Form::FEATURES_OPTIONS[key.to_sym]
        end
      end
    end

    @profile.user = @form.user

    if @profile.save
      @form.increment!(:submissions_count)
      redirect_to thank_you_page_path(token: params[:token])
    else
      render 'manager/forms/show_form', status: :unprocessable_entity
    end
  end

  def show
    @profile = current_user.profiles.with_attached_face_photo
  end

  def modal
    @profile = current_user.profiles.find(params[:id])
    if @profile
      respond_to do |format|
        format.html { render layout: false }
      end
    else
      redirect_to manager_profiles_path, alert: t('profiles_controller.profile_not_found')
    end
  end

  private

  def get_all_agencies
    agent_names = current_user.forms.joins(:profiles).where(profiles: {agency: true}).select('profiles.agent_name').distinct.pluck('profiles.agent_name')
    agent_names.compact.map(&:downcase).uniq.map(&:capitalize)
  end



  # Only allow a list of trusted parameters through.
  def profile_params
    params.require(:profile).permit(
      :name, :surname, :birthdate, :ethnicity, :gender, :city, :email, :phone,
      :agency, :agent_name, :agent_email, :agent_phone, :height, :shirt_size,
      :pants_size, :shoe_size, :hair_type, :hair_color, :eye_color,
      :passport, :driving_license, :food_allergies, :web, :twitter, :facebook,
      :instagram, :tik_tok, :is_an_actor, :performing_arts, :tv, :fiction, :advertising,
      :face_photo, :body_photo, :video_book, :form_id,
      languages: [], available_for: [], sports_outdoor: [], sports_watersports: [],
      sports_martial_arts: [], sports_gymnastics: [], sports_extreme: [], sports_team: [],
      sports_underwater: [], arts_leisure_music: [], arts_leisure_dance: [],
      arts_leisure_stunt_professions: [], general: []
    )
  end
end
