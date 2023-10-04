module Context
  module VagrantHelper
    def delete_vagrant_box(context, box_name)
      context.execute_command(%w(vagrant box remove ) + [box_name])
    end
  end
end