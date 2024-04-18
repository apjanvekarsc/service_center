module RrUnapprovedRecordsHelper
  def filter_records(records)
    result = []
    RrUnapprovedRecord::RR_TABLES.each do |record|
      count = RrUnapprovedRecord.where("rr_approvable_type =?", record).count 
      result << {:record_type => record, :record_count => count}
    end
    result
  end
end
