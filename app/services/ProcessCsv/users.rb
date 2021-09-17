

module ProcessCsv
  class Users
    require 'csv'
    attr_reader :file_path, :insert_limit

    def initialize(file_path: nil, insert_limit: nil)
      @file_path ||= 'public/users.csv'
      @insert_limit ||= 1000
    end

    def call
      users = []
      CSV.foreach(Rails.root.join(file_path), headers: true).with_index do |row, index|
        if users.length == @insert_limit
          import_users users
          users=[]
        end
        users.push(row.to_h)
      end
      import_users users if users.any?
    end

    private

    def import_users users
      User.import users, on_duplicate_key_ignore: true, track_validation_failures: true
    end

  end
end
