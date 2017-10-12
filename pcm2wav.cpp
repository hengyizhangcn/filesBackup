#include <stdio.h>
#include <stdlib.h>
#include <string.h>

using namespace std;
//读文件，返回内存指针，记得free
void* ReadFile(const char *path, unsigned int *len)
{
	FILE *f = fopen(path, "rb");
	if (f == NULL)
		return NULL;
	fseek(f, 0, SEEK_END);
	*len = ftell(f);
	fseek(f, 0, SEEK_SET);
	void *buffer = malloc(*len);
	*len = fread(buffer, 1, *len, f);
	fclose(f);
	return buffer;
}

//pcm转wav，返回wav内存指针和wav长度
void* pcmToWav(const void *pcm, unsigned int pcmlen, unsigned int *wavlen)
{
	//44字节wav头
	void *wav = malloc(pcmlen + 44);
	//wav文件多了44个字节
	*wavlen = pcmlen + 44;
	//添加wav文件头
	memcpy(wav, "RIFF", 4); //标志
	*(int *)((char*)wav + 4) = pcmlen + 36; //从下个地址开始到文件尾的总字节数
	memcpy(((char*)wav + 8), "WAVEfmt ", 8); //4字节的WAV文件标志，接着是波形格式标志fmt ,最后一位空格
	*(int *)((char*)wav + 16) = 16; //过滤字节一般为一般为00000010H
	*(short *)((char*)wav + 20) = 1; //格式种类，值为1时，表示数据为线性pcm编码
	*(short *)((char*)wav + 22) = 1; //通道数，单声道为1，双声道为2
	*(int *)((char*)wav + 24) = 16000; //采样频率
	*(int *)((char*)wav + 28) = 16000; //波形数据传输速率（每秒平均字节数）
	*(short *)((char*)wav + 32) = 16 / 8; //DATA数据块长度，字节
	*(short *)((char*)wav + 34) = 16; //PCM位宽
	strcpy((char*)((char*)wav + 36), "data"); //数据标志符（data）
	*(int *)((char*)wav + 40) = pcmlen; //data总数据长度字节

	//拷贝pcm数据到wav中
	memcpy((char*)wav + 44, pcm, pcmlen);
	return wav;
}

//pcm文件转wav文件，pcmfilePath:pcm文件路劲，wavfilePath:生成的wav路劲
int pcmfileToWavfile(const char *pcmfilePath, const char *wavfilePath)
{
	unsigned int pcmlen;
	//读取文件获得pcm流，也可以从其他方式获得
	void *pcm = ReadFile(pcmfilePath, &pcmlen);
	if (pcm == NULL)
	{
		printf("not found file\n");
		return 1;
	}

	//pcm转wav
	unsigned int wavLen;
	void *wav = pcmToWav(pcm, pcmlen, &wavLen);

	FILE *fwav = fopen(wavfilePath, "wb");
	fwrite(wav, 1, wavLen, fwav);
	fclose(fwav);
	free(pcm);
	free(wav);
	return 0;
}

int main(int argc,char *argv[])
{
	if(argc<3) return 1; 
	if(strstr(argv[1],".pcm")==NULL) return 1;
	if(strstr(argv[2],".wav")==NULL) return 1;
	int ret = pcmfileToWavfile(argv[1],argv[2]);
	if (ret != 0)
	{
		printf("error pcm to wav\n");
	}
	else
	{
		printf("succ");
	}
}
