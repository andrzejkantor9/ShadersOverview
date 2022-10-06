Shader "Mine/BumpedEnviroment" {

    Properties
    {
        _diffuse ("Diffuse Texture", 2D) = "white" {}
        _bump ("Bump Texture", 2D) = "bump" {}
        _bumpAmount ("BumpAmount", Range(0, 10)) = 1
        _brightness ("Brightness", Range(0, 10)) = 1
        _cube ("Cube Map", CUBE) = "white" {}
    }

    SubShader 
    {
        CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _diffuse;
            sampler2D _bump;
            half _bumpAmount;
            half _brightness;
            samplerCUBE _cube;

            struct Input
            {
                float2 uv_diffuse;
                float2 uv_bump;
                float3 worldRefl; INTERNAL_DATA
            };

            void surf (Input IN, inout SurfaceOutput o)
            {
                o.Albedo = tex2D(_diffuse, IN.uv_diffuse).rgb;
                // o.Albedo = texCUBE(_cube, IN.worldRefl).rgb;

                o.Normal = UnpackNormal(tex2D(_bump, IN.uv_bump)) * _brightness;
                o.Normal *= float3(_bumpAmount, _bumpAmount, 1);

                o.Emission = texCUBE (_cube, WorldReflectionVector (IN, o.Normal)).rgb;
            }
        ENDCG
    }

    FallBack "Diffuse"
}