# Cookbook:: deploy-context

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

include_controls "supermarket-profile" do
  def get_control_name(control_name, control_number)
      [control_name, control_number.to_s.rjust(2,'0')].join('-')
  end

  17.times do |control_number|
    skip_control get_control_name('os', control_number)
  end

  10.times do |control_number|
    skip_control get_control_name('package', control_number)
  end

  35.times do |control_number|
    skip_control get_control_name('sysctl', control_number)
  end
end
