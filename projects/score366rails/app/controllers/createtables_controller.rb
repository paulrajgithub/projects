require 'csv'

class CreatetablesController < ApplicationController

  def columnTypes
    return [
        
       :text,
       :text,
       :text,
       :text,
       :text,
       :text,
       :timestamp,
       :timestamp,
       :datetime,
       :boolean,
       :integer,
       :integer,
       :integer,
       :integer,
       :integer,
       :integer,
       :integer,
       :integer
      ]
  end 
  def createtables
    @user = User.update(1, :password => 'password', :password_confirmation => 'password')
      @user.save!
  #   input =  File.join(Rails.root, 'public','tables', 'tables.csv')
  #   count=0
  #   CSV.foreach(input, headers:false,skip_blanks:true) do |line|
  #   	if count == 0 #line 1 headers
  #   	else
  #   		joinTable1 = line[17]
  #       joinTable2 = line[18]
  #       isJointable=false
  #       if not joinTable1.nil? and joinTable1.length >0 and not joinTable2.nil? and joinTable2.length >0
          
  #         isJointable =true
  #       end

  # 		  unless ActiveRecord::Base.connection.table_exists? line[0]
  #         if isJointable
  #           createJoinTable joinTable1, joinTable2
  #         else
  #           createTable line
  #         end
		#     end
		#   end
		#   count = count+1
		# end

  #   count=0
  #   CSV.foreach(input, headers:false,skip_blanks:true) do |line|
  #     if count==0
  #     else
  #       columnIndex=1
  #       columnTypes.each do |type|
  #         value = line[columnIndex]
  #         # addForeignKeys value, columnIndex, line
  #         columnIndex = columnIndex+1
  #       end
  #     end
  #     count = count+1
  #   end
    render json: "done user"
  end

  def createJoinTable table1, table2
    column1 = joinTable1.singularize
    column2 = joinTable2.singularize
    table=nil
    ActiveRecord::Base.connection.create_join_table joinTable1.to_sym, joinTable2.to_sym do |t|
      t.column :id, :primary_key
      t.index (column1+"_id").to_sym
      t.index (column2+"_id").to_sym
      table = t.name
    end
    ActiveRecord::Base.connection.rename_column(table, (column1+"_id"), (column1+"id"))
    ActiveRecord::Base.connection.rename_column(table, (column2+"_id"), (column2+"id"))
    # add_column :table_name, :id, :primary_key
    # add_column :table_name, :active, :boolean
    # add_column :table_name, :sequence, :integer
  end

  def createTable line
    
    ActiveRecord::Base.connection.create_table(line[0].to_sym) do |t|
      columnIndex=1
      columnTypes.each do |type|
        value = line[columnIndex]
        if [13,14,15,16].include?columnIndex and not (value.nil? or value=="")
          tempStr = value[/\(.*?\)/]
          value = value.gsub(tempStr, "") if not tempStr.nil?
        end
        if not (value.nil? or value=="")
          t.column value.to_sym, type
        end
        columnIndex = columnIndex+1
      end
    end
  end
  def addForeignKeys value, columnIndex, line
    belongsTo=[13,14,15,16]
    if not value.nil? and not value=="" and belongsTo.include? columnIndex
        # add_reference(value.to_sym, column.to_sym, index: true)
      if not (value.nil? or value=="")
        tempStr = value[/\(.*?\)/] 
        if not tempStr.nil?
          value = value.gsub(tempStr, "")
          table2 = tempStr.gsub('(', "").gsub(')', "")
          columnname = tempStr.gsub('(', "").gsub(')', "").gsub('s', "") +"id"
          ActiveRecord::Base.connection.add_foreign_key line[0], table2, column: value.to_sym
        end
      end
    end
  end
end