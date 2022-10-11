Shader "Mine/AdvancedEffects/Glass"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _BumpMap ("Normal map", 2D) = "bump" {}
        _ScaleUV ("Scale", Range(1, 50)) = 1
    }
    SubShader
    {
        Tags
        {
            "Queue" = "Transparent"
        }

        GrabPass {}

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;

                float4 uvgrab : TEXCOORD1;
                float2 uvbump : TEXCOORD2;
            };

            sampler2D _GrabTexture;

            sampler2D _MainTex;
            float4 _MainTex_ST;
            
            //"size" of pixels in end material
            float4 _GrabTexture_TexelSize;
            float _ScaleUV;

            sampler2D _BumpMap;
            float4 _BumpMap_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                
                o.uvgrab.xy = (-float2(o.vertex.x, o.vertex.y) + o.vertex.w) * 0.5;
                o.uvgrab.zw = o.vertex.zw;
                
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.uvbump = TRANSFORM_TEX(v.uv, _BumpMap);

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                half2 bump = UnpackNormal(tex2D(_BumpMap, i.uvbump)).rg;
                float2 offset = bump * _ScaleUV * _GrabTexture_TexelSize.yx;
                i.uvgrab.xy = offset * i.uvgrab.z + i.uvgrab.xy;

                fixed4 col = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(i.uvgrab));
                // fixed4 col = tex2D(_MainTex, i.uv);

                fixed4 tint = tex2D(_MainTex, i.uv);
                col *= tint;

                return col;
            }
            ENDCG
        }
    }
}
