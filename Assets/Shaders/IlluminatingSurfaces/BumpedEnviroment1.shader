Shader "Mine/BumpedEnviroment1" {

    Properties
    {
        _bump ("Bump Texture", 2D) = "bump" {}
        _cube ("Cube Map", CUBE) = "white" {}
    }

    SubShader 
    {
        CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _bump;
            samplerCUBE _cube;

            struct Input
            {
                float2 uv_bump;
                float3 worldRefl; INTERNAL_DATA
            };

            void surf (Input IN, inout SurfaceOutput o)
            {
                o.Normal = UnpackNormal(tex2D(_bump, IN.uv_bump)) * 0.3;
                o.Albedo = texCUBE (_cube, WorldReflectionVector (IN, o.Normal)).rgb;
            }
        ENDCG
    }

    FallBack "Diffuse"
}