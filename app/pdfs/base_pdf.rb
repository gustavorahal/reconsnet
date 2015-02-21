class BasePdf < Prawn::Document

  def gen_table(data, cell_style=nil)
    table data do
      row(0).font_style = :bold
      row(0).align = :center
      row(0).font_size = 13
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      if cell_style
        self.cell_style = cell_style
      end
    end
  end

end