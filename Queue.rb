# -*- coding: utf-8 -*-
class Queue
  #class method
  def self.make_q(size)
    q=self.new()
    q.init_q(size)
    q
  end
  
  #instance variables and accessors
  attr_accessor("queue","qsize","front","rear","qlen")
  
  #instance methods
  def init_q(size)
    @queue = Array.new(size)
    @qsize,@front,@rear,@qlen=size,0,0,0
    self
  end

  def enq(item)
    if @qlen==@qsize
      return false
    end
    @queue[@rear] = item
    @rear = (@rear+1) % @qsize #rearを一つ増やす。行き過ぎたら先頭へ
    @qlen = @qlen+1
    true
  end

  def deq()
    if @qlen==0
      return nil
    end
    item = @queue[@front]
    @front=(@front+1) % @qsize  #frontを一つ増やす。行き過ぎたら先頭へ
    @qlen=@qlen-1
    item
  end

  def enq_p(item)                   #テスト用,enqの結果、直後のキューの状態
    result = self.enq(item)
    print result
    putc 9
    self.prq()
  end

  def deq_p()                       #テスト用,deqの結果、直後のキューの状態
    result = self.deq()
    print result
    putc 9
    self.prq()
  end

  def prq()                         #キュー本体の状態
    printf("(qsize,front,rear,qlen)=(%d,%d,%d,%d)",@qsize,@front,@rear,@qlen)
    putc 9
    for i in 0..@qlen-1
      print(@queue[(@front+i)%@qsize])
      putc ' '
    end
    puts ""
  end
end

class ExpandQueue < Queue
  def enq(item)
    if super(item)==true
      return true
    end
    newsize = 2*@qsize
    newq=Array.new(newsize)
    for i in 0..@qlen-1
      newq[i] = @queue[(@front+1)%@qsize]
    end
    newq[@len]=item
    @queue=newq
    @qsize=newsize
    @qlen=@qlen+1
    @front=0
    @rear=@qlen
    true
  end
end
