include(Math)

class MyPoint
  def quadrant()
    a=self.theta()
    if a< -PI/2
      3
    elsif a<0
      4
    elsif a < PI/2
      1
    else
      2
    end
  end
end

class RecPoint <MyPoint
  attr_accessor("x","y")
  
  def set_xy(x,y)
    @x,@y=x,y
  end
  
  def r()
    sqrt(@x*@x+@y*@y)
  end
  
  def theta()
    if @x==0
      if @y>0
        return PI/2
      elsif @y<0
        return -PI/2
      else
        return 0
      end
    end
    result=atan(@y/@x)
    if @x<0
      result +=PI
    end
    if result >PI
      result -PI*2
    else
      result
    end
  end
end

class PolPoint < MyPoint
  attr_accessor("r","theta")
  def set_rt(r,t)
    @r,@theta=r,t
  end
  
  def x()
    @r*cos(theta)
  end

  def y()
    @r*sin(@theta)
  end
  
end
