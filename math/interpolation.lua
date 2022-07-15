local function interpolate_to(vector1, vector2, alpha)
    return vector1 + (vector2 - vector1) * alpha
end

return {
    interpolate_to = interpolate_to,
}