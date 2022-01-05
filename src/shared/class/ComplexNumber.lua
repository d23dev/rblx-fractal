local ComplexNumber = {}
ComplexNumber.__index = ComplexNumber

type ComplexNumber = {
    Real: number;
    Imaginary: number;
}

function ComplexNumber.new (r: number?, i: number?)
    local self: ComplexNumber = setmetatable({}, ComplexNumber)
    self.Real = r or 0
    self.Imaginary = i or 0
    return self
end

function ComplexNumber:Multiply (other: ComplexNumber)
    return {
        Real = self.Real * other.Real - self.Imaginary * other.Imaginary;
        Imaginary = self.Real * other.Imaginary + self.Imaginary * other.Real;
    }
end

function ComplexNumber:Square ()
    return self:Multiply(self)
end

function ComplexNumber:Add (other: ComplexNumber)
    return {
        Real = self.Real + other.Real;
        Imaginary = self.Imaginary + other.Imaginary;
    }
end

return ComplexNumber