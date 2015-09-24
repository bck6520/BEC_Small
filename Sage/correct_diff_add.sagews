︠45bb2f33-e5be-445c-b47b-b697fbcfc55ds︠
def mynumerator(x):
  if parent(x) == R:
    return x
  return numerator(x)

class fastfrac:
  def __init__(self,top,bot=1):
    if parent(top) == ZZ or parent(top) == R:
      self.top = R(top)
      self.bot = R(bot)
    elif top.__class__ == fastfrac:
      self.top = top.top
      self.bot = top.bot * bot
    else:
      self.top = R(numerator(top))
      self.bot = R(denominator(top)) * bot
  def reduce(self):
    return fastfrac(self.top / self.bot)
  def sreduce(self):
    return fastfrac(I.reduce(self.top),I.reduce(self.bot))
  def iszero(self):
    return self.top in I and not (self.bot in I)
  def isdoublingzero(self):
    return self.top in J and not (self.bot in J)
  def __add__(self,other):
    if parent(other) == ZZ:
      return fastfrac(self.top + self.bot * other,self.bot)
    if other.__class__ == fastfrac:
      return fastfrac(self.top * other.bot + self.bot * other.top,self.bot * other.bot)
    return NotImplemented
  def __sub__(self,other):
    if parent(other) == ZZ:
      return fastfrac(self.top - self.bot * other,self.bot)
    if other.__class__ == fastfrac:
      return fastfrac(self.top * other.bot - self.bot * other.top,self.bot * other.bot)
    return NotImplemented
  def __neg__(self):
    return fastfrac(-self.top,self.bot)
  def __mul__(self,other):
    if parent(other) == ZZ:
      return fastfrac(self.top * other,self.bot)
    if other.__class__ == fastfrac:
      return fastfrac(self.top * other.top,self.bot * other.bot)
    return NotImplemented
  def __rmul__(self,other):
    return self.__mul__(other)
  def __div__(self,other):
    if parent(other) == ZZ:
      return fastfrac(self.top,self.bot * other)
    if other.__class__ == fastfrac:
      return fastfrac(self.top * other.bot,self.bot * other.top)
    return NotImplemented
  def __pow__(self,other):
    if parent(other) == ZZ:
      return fastfrac(self.top ^ other,self.bot ^ other)
    return NotImplemented

def isidentity(x):
  return x.iszero()

def isdoublingidentity(x):
  return x.isdoublingzero()

R.<ud,ud2overd1plus1,ux3,uy3,ux2,uy2,uw1,uw2,uw3> = PolynomialRing(GF(2),9,order='invlex')
ux_2 = (uy2)
uy_2 = (ux2)
ux1 = ((ud*(ux3+ux_2)+ud*(ux3+uy3)*(ux_2+uy_2)+(ux3+ux3^2)*(ux_2*(uy3+uy_2+1)+uy3*uy_2))/(ud+(ux3+ux3^2)*(ux_2+uy_2)))
uy1 = ((ud*(uy3+uy_2)+ud*(ux3+uy3)*(ux_2+uy_2)+(uy3+uy3^2)*(uy_2*(ux3+ux_2+1)+ux3*ux_2))/(ud+(uy3+uy3^2)*(ux_2+uy_2)))
I = R.ideal([
  mynumerator((ud*(ux1+uy1)+ud*(ux1^2+uy1^2))-((ux1+ux1^2)*(uy1+uy1^2)))
, mynumerator((ux1+uy1)-(uw1))
, mynumerator((ud*(ux2+uy2)+ud*(ux2^2+uy2^2))-((ux2+ux2^2)*(uy2+uy2^2)))
, mynumerator((ux2+uy2)-(uw2))
, mynumerator((ud*(ux3+uy3)+ud*(ux3^2+uy3^2))-((ux3+ux3^2)*(uy3+uy3^2)))
, mynumerator((ux3+uy3)-(uw3))
, mynumerator((ud2overd1plus1)-(ud/ud+1))
])

ud = fastfrac(ud)
ud2overd1plus1 = fastfrac(ud2overd1plus1)
ux3 = fastfrac(ux3)
uy3 = fastfrac(uy3)
ux2 = fastfrac(ux2)
uy2 = fastfrac(uy2)
uw1 = fastfrac(uw1)
uw2 = fastfrac(uw2)
uw3 = fastfrac(uw3)
ux_2 = fastfrac(ux_2)
uy_2 = fastfrac(uy_2)
ux1 = fastfrac(ux1)
uy1 = fastfrac(uy1)

uA = (uw2+uw3)^2
uB = uA/uw1
uN = uA+uB
uD = uB + fastfrac(1)
uE = fastfrac(1)/uD
uw5 = uN*uE

ux5 = (((ud*(ux3+ux2)+ud*(ux3+uy3)*(ux2+uy2)+(ux3+ux3^2)*(ux2*(uy3+uy2+fastfrac(1))+uy3*uy2))/(ud+(ux3+ux3^2)*(ux2+uy2)))).reduce()
uy5 = (((ud*(uy3+uy2)+ud*(ux3+uy3)*(ux2+uy2)+(uy3+uy3^2)*(uy2*(ux3+ux2+fastfrac(1))+ux3*ux2))/(ud+(uy3+uy3^2)*(ux2+uy2)))).reduce()

print isidentity((ud*(ux5+uy5)+ud*(ux5^2+uy5^2))-((ux5+ux5^2)*(uy5+uy5^2))) or isidentity(uy1*uy1*uy2*uy3*ux1*ux1*ux2*ux3*((ud*(ux5+uy5)+ud*(ux5^2+uy5^2))-((ux5+ux5^2)*(uy5+uy5^2))))
print isidentity((ux5+uy5)-(uw5)) or isidentity(uy1*uy1*uy2*uy3*ux1*ux1*ux2*ux3*((ux5+uy5)-(uw5)))
︡05c351a8-09d0-4ec4-b9fb-131a02283a78︡{"stdout":"True\n"}︡{"stdout":"True\n"}︡
︠71f6e47f-4664-4f8b-a862-680c8ae067bd︠
︡dfa001d6-dd93-4d8c-ab50-8d5d6be9c373︡
︠221b7896-4d02-49d0-bf69-d8b4021d518e︠









