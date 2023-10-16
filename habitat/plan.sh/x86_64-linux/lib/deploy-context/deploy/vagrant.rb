module Context
  module VagrantHelper
    def delete_vagrant_box(context, box_name, command_type = :system)
      context.execute_command(%w(vagrant box remove ) + [box_name], command_type)
    end
  end
end