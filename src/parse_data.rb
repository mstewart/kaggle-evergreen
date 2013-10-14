require 'csv'

def has_date?(url)
  if url.match(/20[0-1][0-9]/)
    return 1
  end

  return 0
end

def is_static?(url)
  if url.match(/\.html{0,1}$/)
    return 1
  end
  return 0
end

def remapRow(row, additions)
  last = row[row.size() - 1]
  row.delete_at(row.size() -1 )
  row = row + additions
  row = row.push(last)
  return row

end

fhRead = open(ARGV[0], "rb")


lCount = 0

CSV.open(ARGV[1], "wb", options={:col_sep => "\t"}) do |csvWrite|
  fhRead.each_line() do |line|

    CSV.parse(line, options={:col_sep => "\t"}) do |row|

      if lCount == 0
        csvWrite << remapRow(row , ["domain", "static", "depth", "containsDate"])
      else

        url = row[0]
        urlSplit = url.split('/')
        domain = urlSplit[2]
        containsDate = has_date?(url)
        static = is_static?(url)
        depth = urlSplit.size() - 3
        csvWrite << remapRow( row , [domain, static, depth, containsDate])
      end
    end
    lCount = lCount + 1

  end
end