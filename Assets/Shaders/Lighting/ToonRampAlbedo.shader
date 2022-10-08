Shader "Mine/Lighting/ToonRampAlbedo"
{
    Properties
    {
        _Color("Color", Color) = (1, 1, 1, 1)
        _RampTexture ("Ramp Texture", 2D) = "white" {}
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
        }

        CGPROGRAM
        #pragma surface surf ToonRamp

        float4 _Color;
        sampler2D _RampTexture;

        half4 LightingToonRamp (SurfaceOutput s, fixed3 lightDir, fixed atten)
        {
            float diff = dot (s.Normal, lightDir);
            float h = diff * 0.5 + 0.5;
            float2 rh = h;
            float3 ramp = tex2D(_RampTexture, rh).rgb;

            float4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * (ramp);
            c.a = s.Alpha;
            return c;
        }

        struct Input
        {
            float2 uv_MainTex;

            float3 viewDir;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            // o.Albedo = _Color.rgb;

            float diff = dot (o.Normal, IN.viewDir);
            float h = diff * 0.5 + 0.5;
            float2 rh = h;
            float3 colorRamp = tex2D(_RampTexture, rh).rgb;

            o.Albedo = _Color.rgb * colorRamp;
        }
        ENDCG
    }

    FallBack "Diffuse"
}