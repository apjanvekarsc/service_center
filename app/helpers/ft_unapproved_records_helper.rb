module FtUnapprovedRecordsHelper
  def filter_records(records)
    result = []
    FtUnapprovedRecord::FT_TABLES.each do |record|
      count = FtUnapprovedRecord.where("ft_approvable_type =?",record).count 
      result << {:record_type => record, :record_count => count}
    end
    result
  end
end
