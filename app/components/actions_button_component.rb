class ActionsButtonComponent < ViewComponent::Base
  def initialize actions = {}, data_hash = {}
    @actions = actions
    @data_hash = data_hash
  end

  def action_icons
    {
      edit_link: 'pencil',
      show_link: 'eye',
      destroy_link:'trash',
      copy_link: 'clipboard',
      resend_link: 'send',
      list_services: 'card-list',
      refresh_link: 'arrow-clockwise',
      ban_group_member_link: 'lock',
      unban_group_member_link: 'unlock',
      restrict_group_member_link: 'slash-circle',
      promote_group_member_link: 'award',
      show_messages_link: 'chat-right',
      print_report_link: 'printer'
    }
  end

  def copy_success
    '<i class="bi bi-clipboard-check mr-2 text-green-400"></i> <div class="text-green-400">Copied!</div>'
  end
end
