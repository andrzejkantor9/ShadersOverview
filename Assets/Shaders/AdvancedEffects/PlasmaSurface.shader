Shader "Mine/AdvancedEffects/PlasmaSurface"
{
    Properties
    {
        _Tint ("Color Tint", Color) = (1, 1, 1, 1)
        _Speed ("Speed", Range(1, 100)) = 10
        _Scale1("Scale 1", Range(0.1, 10)) = 2
        _Scale2("Scale 2", Range(0.1, 10)) = 2
        _Scale3("Scale 3", Range(0.1, 10)) = 2
        _Scale4("Scale 4", Range(0.1, 10)) = 2
    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float2 uv_MainTex;
            float3 worldPos;
        };

        float4 _Tint;
        float _Speed;
        float _Scale1;
        float _Scale2;
        float _Scale3;
        float _Scale4;

        
        //dependent on z / y in world space
        void surf (Input IN, inout SurfaceOutput o)
        {
            const float PI = 3.14159265;
            float time = _Time.x * _Speed;

            //vertical
            float color = sin(IN.worldPos.x * _Scale1 + time);

            //horizontal
            color += sin(IN.worldPos.z * _Scale2 + time);
            
            //diagonal
            color += sin(_Scale3 * (IN.worldPos.x * sin(time / 2) + IN.worldPos.z * cos(time / 3)) + time);

            //circular
            float c1 = pow(IN.worldPos.x + 0.5 * sin(time / 5), 2);
            float c2 = pow(IN.worldPos.z + 0.5 * sin(time / 3), 2);
            color += sin(sqrt(_Scale4 * (c1 + c2) + 1 + time));

            o.Albedo.r = sin(color / 4.0 * PI);
            o.Albedo.g = sin(color / 4.0 * PI + 2 * PI / 4);
            o.Albedo.b = sin(color / 4.0 * PI + 4 * PI / 4);

            o.Albedo *= _Tint;
        }
        ENDCG
    }

    Fallback "Diffuse"
}
