
shader_type canvas_item;

// Hole radius in pixels
uniform float hole_radius = 10.0;

// Smoothstep for antialiasing
uniform float edge_smoothstep = .5;

// Node size in pixels (Have to inject it by node script)
instance uniform vec2 size = vec2(100.0, 100.0);
instance uniform vec4 border_color: source_color = vec4(1.0);
instance uniform vec4 shadow_color : source_color = vec4(1.0, 0.0, 0.0, .5);
// Shadow offset
instance uniform vec2 shadow = vec2(3.0, 5.0);

// UV in Pixels
varying vec2 uv_pixels;

void vertex() {

    // Środek ustawiamy na (0.5, 0.5)
    vec2 norm_pos = UV - vec2(0.5);
    
    // Margines potrzebny aby narysować cień
    float margin_pixels = max(abs(shadow.x), abs(shadow.y));
    
    // VERTEX powiększony o margines
    VERTEX += norm_pos * margin_pixels * 2.0;
    
    // uv w pixelach
    uv_pixels = norm_pos * (size + margin_pixels * 2.0);
}

// Budujemy jednocześnie obie strony ramki w kierunku jednej osi
float build_border(float main_axis_position, float cross_axis_position, float obj_dimention, float obj_cross_dimention) {
  // Zakładam że ramka składa się z n dziur o promieniu r, 
  // rozdzielonych przerwami o wymiarze p >= r.
  // Pierwsze dziury zaczynają sie na rogach
  
  // Teoretyczna ilość dziur (nie licząc narożnych).
  float fnX = obj_dimention / (3.0 * hole_radius) - 1.0;
  
  // Praktyczne (całkowita) ilość dziur.
  float nX = floor(fnX);
  
  // Szerokość obiektu jezeli x = r;
  float ideal_obj_width = 3.0 * hole_radius * (1.0 + nX);
  
  // Róznica między idealną a prawdziwą szerokością obiektu
  float dnX = obj_dimention - ideal_obj_width;
  
  // Ilość przerw
  float pX = nX + 1.0;
  
  // Korekta szerokości przerwy.
  float dpWidht = dnX / pX;
  
  // Realna szerokość przerw
  float pWidth = hole_radius + dpWidht;
  
  // Kazdy segment składa się z dwóch promieni dziury i jednej przerwy
  // Szerowkość segmentu.
  float segmentWidth = 2.0 * hole_radius + pWidth;

  // Wyliczamy x w relacji do segmentu
  float dx = mod(main_axis_position, segmentWidth);
  dx -= step(segmentWidth / 2.0, dx) * segmentWidth;

  // Dziura górna
  vec2 c1 = vec2(0.0, 0.0);
  // Dzira dolna
  vec2 c2 = vec2(0.0, obj_cross_dimention);
  
  // UV w segmencie w pixelach
  vec2 uv = vec2(dx, cross_axis_position);
  
  // Odleglość od górnej dziury
  float l1 = length(uv - c1);
  
  // Odleglość od dolnej dziury
  float l2 = length(uv - c2);
  
  // Odleglość do najbliższej dziury
  float l = min(l1, l2);
  
  // Smoothstep aby pozbyć się pixelozy przy obracaniu obiektem
  return smoothstep(hole_radius - edge_smoothstep, hole_radius + edge_smoothstep, l);
}

// Kształ zbudowany jest z dwóch części: wzoru osi X i wzoru osi Y;
float get_shape(float x, float y) {
  vec2 half_size = size / 2.0;
  float is_in_shape = step(-half_size.x, x) * step(x, half_size.x) * step(-half_size.y, y) * step(y, half_size.y);
  
  float _x = x + half_size.x;
  float _y = y + half_size.y;
  float x_alpha = build_border(_x, _y, size.x, size.y);
  float y_alpha = build_border(_y, _x, size.y, size.x);
  return is_in_shape * x_alpha * y_alpha;
}

void fragment() {
  float x = uv_pixels.x;
  float y = uv_pixels.y;
  
  // Głowny kształ znaczka
  float shape = get_shape(x, y);
  
  // Przesunięsie cienia
  float _sx = x + size.x / 2.0 - shadow.x;
  float _sy = y + size.y / 2.0 - shadow.y;
  
  // Kształ cienia
  float shadow_shape = get_shape(x - shadow.x, y - shadow.y);
  
  vec4 final_color_1 = mix(vec4(shadow_color.rgb, 0.0), shadow_color, shadow_shape);
  vec4 final_color_2 = mix(vec4(border_color.rgb, 0.0), shadow_color, shape);
  
  vec4 final_color = mix(final_color_1, border_color, shape);
  
  COLOR = final_color;
  
}
