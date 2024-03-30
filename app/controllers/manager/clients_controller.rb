class Manager::ClientsController < ApplicationController

  def index
    @data_for_show = [ :id, :first_name, :last_name, :email, :created_at, :invitation_accepted_at, :destroy_link ]
    @keys_for_hide = [:id, :destroy_link]
    @searchable_keys = %w[first_name last_name email]
    @sorting_keys = %w[first_name last_name email]

    @title = I18n.t('clients_controller.title')
    @description = I18n.t('clients_controller.description')
    @header_buttons = [{ icon: 'plus-circle', class: 'inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-shadowy-300 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50', link: new_manager_client_path, text: I18n.t('clients_controller.invite_button'), data: { turbo_frame: 'modal' } }]

    @clients = User.clients(current_user)

    if @clients.any?
      @actions = {
        destroy_link: {
          extra_options: { data: { turbo_frame: '_top', turbo_method: :delete, turbo_confirm: t('clients_controller.destroy') } }
        }
      }
      @excluded_keys = @keys_for_hide
    else
      @empty_content = {
        title: I18n.t('clients_controller.no_clients_title'),
        message: I18n.t('clients_controller.no_clients_message'),
        main_icon: 'people-fill'
      }
    end

    @pagy, @data_collection = pagy_array(get_clients_collection(@clients), items: get_items, size: [1,2,2,1])
  end

  def new
    respond_to do |format|
      format.html { render layout: false }
      format.turbo_stream
    end
  end

  def invite
    invite_params = user_params.merge(role: :client)
    @user = User.invite!(invite_params, current_user)
    if @user.errors.empty?
      redirect_to manager_clients_path, notice: I18n.t('clients_controller.invite_success')
    else
      flash[:error] = I18n.t('clients_controller.invite_error')
      render :new
    end
  end

  def destroy
    @client = User.clients(current_user).find_by(id: params[:id])

    if @client
      if @client.destroy
        redirect_to manager_clients_path, notice: I18n.t('clients_controller.delete_success')
      else
        redirect_to manager_clients_path, alert: I18n.t('clients_controller.delete_error')
      end
    else
      redirect_to manager_clients_path, alert: I18n.t('clients_controller.not_found_or_no_permission')
    end
  end

  private

  def user_params
    params.permit(:email)
  end

  def get_clients_collection(clients)
    result = []
    clients.each do |client|
      client_data_hash = {}
      @data_for_show.each do |key|
        case key
        when :invitation_accepted_at
          case client[key]
          when nil
            client_data_hash[key] = BadgeComponent.new(text: t('clients_controller.status.pending'), type: 'red')
          else
            client_data_hash[key] = BadgeComponent.new(text: t('clients_controller.status.accepted'), type: 'green')
          end
        when :destroy_link
          client_data_hash[key] = manager_client_path(client)
        when :created_at
          client_data_hash[key] = global_datetime_format(client[key])
        else
          client_data_hash[key] = client[key]
        end
      end
      result.push client_data_hash
    end
    result
  end
end
