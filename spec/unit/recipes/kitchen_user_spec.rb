#
# Cookbook:: deploy-context
# Spec:: kitchen_user
#
# Copyright:: 2023, The Authors, All Rights Reserved.

require 'chefspec'
require 'chefspec/berkshelf'

describe 'deploy-context::kitchen_user' do
  context 'When all attributes are default, on Ubuntu 22.04 for deploy-context recipe' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/main/PLATFORMS.md
    platform 'ubuntu', '22.04'

    it 'converges successfully Ubuntu 22.04 for deploy-context recipe' do
      expect { chef_run }.to_not raise_error
    end
  end

  context 'When all attributes are default, on Ubuntu 20.04 for kitchen_user recipe' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/main/PLATFORMS.md
    platform 'ubuntu', '20.04'

    it 'converges successfully Ubuntu 20.04 for deploy-context' do
      expect { chef_run }.to_not raise_error
    end
  end

  context 'When all attributes are default, on CentOS 8 for kitchen_user recipe' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/main/PLATFORMS.md
    platform 'centos', '8'

    it 'converges successfully CentOS 8 for deploy-context' do
      expect { chef_run }.to_not raise_error
    end
  end

  context 'When all attributes are default, on Windows 10 for kitchen_user recipe' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/main/PLATFORMS.md
    platform 'windows', '10'

    it 'converges successfully Windows 10 for kitchen_user recipe' do
      expect { chef_run }.to_not raise_error
    end
  end

  context 'When all attributes are default, on Windows 2019 for kitchen_user recipe' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/main/PLATFORMS.md
    platform 'windows', '2019'

    it 'converges successfully Windows 2019 for kitchen_user recipe' do
      expect { chef_run }.to_not raise_error
    end
  end

  context 'When all attributes are default, on no platform for kitchen_user recipe' do
    it 'converges successfully Windows 2019 for kitchen_user recipe' do
      expect { chef_run }.to_not raise_error
    end
  end
end
