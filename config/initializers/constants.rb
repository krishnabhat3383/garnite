# frozen_string_literal: true

module Constants
  IS_SQLITE_DB = ActiveRecord::Base.connection_db_config.configuration_hash[:adapter] == "sqlite3"
  DB_REGEX_OPERATOR = IS_SQLITE_DB ? "REGEXP" : "~*"
end
