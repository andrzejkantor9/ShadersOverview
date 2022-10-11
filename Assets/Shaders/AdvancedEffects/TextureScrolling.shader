Shader "Mine/AdvancedEffects/TextureScrolling"
{
    Properties
    {
        _MainTexture ("Texture", 2D) = "white" {}
        _ExtraTexture ("Extra Texture", 2D) = "white" {}
        _ScrollX ("Scroll X", Range(-5, 5)) = 1
        _ScrollY ("Scroll Y", Range(-5, 5)) = 1

        _ScrollSpeedRetaltion("Scroll Speed Relation", Range(0.01, 10)) = 1
    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float2 uv_MainTexture;
        };

        sampler2D _MainTexture;
        sampler2D _ExtraTexture;
        float _ScrollX;
        float _ScrollY;

        float _ScrollSpeedRetaltion;

        //commented out - simple one texture scroll
        void surf (Input IN, inout SurfaceOutput o)
        {
            _ScrollX *= _Time;
            _ScrollY *= _Time;
            
            // float2 newuv = IN.uv_MainTex + float2(_ScrollX, _ScrollY);
            float3 mainColor = (tex2D (_MainTexture, IN.uv_MainTexture + float2(_ScrollX, _ScrollY))).rgb;
            float3 extraColor = (tex2D (_ExtraTexture, IN.uv_MainTexture + float2(_ScrollX, _ScrollY) * _ScrollSpeedRetaltion)).rgb;

            // o.Albedo = tex2D (_MainTexture, newuv);
            o.Albedo = (mainColor + extraColor) / 2.0;
        }

        ENDCG
    }

    Fallback "Diffuse"
}
