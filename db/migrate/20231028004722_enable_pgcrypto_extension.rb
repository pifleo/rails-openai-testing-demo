# https://lab.io/articles/2017/04/13/uuids-rails-5-1/
class EnablePgcryptoExtension < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  end
end
