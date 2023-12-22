module JobLogs
  class GetJobLogs
    include Interactor::Organizer

    organize SearchJobLogs, PaginateRecords
  end
end