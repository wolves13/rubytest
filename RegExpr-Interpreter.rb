# -*- coding: utf-8 -*-
class RegularExpression
end

def makeset(str)
  s = Set.new()
  s.add(str)
  s
end

class AlternationExpression < RegularExpression  #<選択式>に対応するクラス
  #class method
  def self.make_expr(a1,a2)  #instancsesの生成
    r=self.new()             #newでinstancesを作り
    r.alternative1=a1        #各instancesに設定
    r.alternative2=a2
    r
  end
  
  #instance variables and accessors
  attr_accessor("alternative1","alternative2")  #左右のオペランド
  
  #instance methods
  #AlternationExpressionクラスのmatch
  def match(input)
    s1 = @alternative1.match(input)
    s2 = @alternative2.match(input)
    s1+s2
  end
  
end

class SequenceExpression < RegularExpression    #<連接式>に対応するクラス
  #class metod
  def self.make_expr(e1,e2)    #インスタンスに生成
    r=self.new()               #生成の仕方は上と同じ
    r.expression1=e1
    r.expression2=e2
    r
  end
  
  #instance variables and accessors
  attr_accessor("expression1","expression2")     #左右のオペランド
  
  #instance methods
  #SequenceExpressionクラスのmatch
  def match(input)
    s1 = @expression1.match(input)
    s2 = @expression2.match(s1)
    s2
  end
  
end

class RepetitionExpression < RegularExpression   #<反復式>に対応するクラス
  #class method
  def self.make_expr(p)       #インスタンスの生成
    r=self.new()
    r.repetition=p
    r
  end
  
  #instance variables and accessors
  attr_accessor("repetition")                 #オペランド

  #instance methods
  #RepetitionExpressionクラスのmatch
  def match(input)
    s=input                         #繰返しごとの状態を保持
    output = input                  #はじめ出力は繰返しが0回の場合の状態としておく
    while(!s.empty?())              #sが空集合になるまで繰り返す
      s=@repetition.match(s)        #@repetitionとのマッチを一回適用し次の状態を得る
      output=output+s               #出力に得られた状態を追加
    end
    output
  end

end

class LiteralExpression < RegularExpression    #<リテラル式>に対応するクラス
  #class method
  def self.make_expr(c)        #インスタンスの生成
    r=self.new()
    r.components=c
    r
  end

  #instance variables and accessors
  attr_accessor("components")         #stringクラスのオブジェクト
  
  #instance methods
  #LiteralExpressionクラスのmatch
  def match(input)
    output = Set.new()                #出力,はじめは空集合
    len = @components.length()        #@componentsの長さ
    input.each{|str|                  #strはinputの各要素が順番に束縛される
      if(len <= str.length() &&       #strの文字数がlen以上でなおかつ,
         str[0..len-1] == @components)  #先頭から@componentsと一致すれば
        output.add(str[len..-1])      #len文字以降を残余文字列として出力に追加
      end }
    output
  end
  
end
