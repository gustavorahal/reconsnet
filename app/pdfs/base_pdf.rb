class BasePdf < Prawn::Document

  @@default_font = 'Helvetica'

  def gen_table(data, cell_style=nil, column_widths={})
    table data do
      row(0).font_style = :bold
      row(0).align = :center
      self.column_widths = column_widths
      self.header = true
      self.row_colors = ['EEEEEE', 'FFFFFF']
      if cell_style
        self.cell_style = cell_style
      end
    end
  end

end