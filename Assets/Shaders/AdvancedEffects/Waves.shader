Shader "Mine/AdvancedEffects/Waves"
{
    Properties
    {
        _MainTexture ("Diffuse", 2D) = "white" {}
        _Tint ("Color Tint", Color) = (1, 1, 1, 1)
        _Frequency ("Frequency", Range(0, 5)) = 3
        _Speed ("Speed", Range (0, 100)) = 10
        _Amplitude ("Amplitude", Range (0, 1)) = 0.5
    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert

        float4 _Tint;
        float _Frequency;
        float _Speed;
        float _Amplitude;

        struct appdata
        {
            float4 vertex: POSITION;
            float3 normal: NORMAL;
            float4 texcoord: TEXCOORD0;
            float4 texcoord1: TEXCOORD1;
            float4 texcoord2: TEXCOORD2;
        };

        struct Input
        {
            float2 uv_MainTexture;
            float3 vertexColor;
        };

        void vert (inout appdata v, out Input o)
        {
            UNITY_INITIALIZE_OUTPUT(Input, o);

            float time = _Time * _Speed;
            // float waveHeight = sin(time + v.vertex.x * _Frequency) * _Amplitude;
            float waveHeight = sin(time + v.vertex.x * _Frequency) * _Amplitude
                + sin(time * 2 + v.vertex.x * _Frequency * 2) * _Amplitude;

            v.vertex.y = v.vertex.y + waveHeight;
            v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z));

            o.vertexColor = waveHeight + 1;
        }

        sampler2D _MainTexture;

        void surf (Input IN, inout SurfaceOutput o)
        {
            float4 color = tex2D(_MainTexture, IN.uv_MainTexture);

            o.Albedo = color * IN.vertexColor.rgb;
        }

        ENDCG
    }

    Fallback "Diffuse"
}
