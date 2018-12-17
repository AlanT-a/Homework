#include<bits/stdc++.h>
#include<conio.h>
#define MaxVertexNum 200
#define MAX 999999
using namespace std;

typedef struct {
    int num;//���
    char name[100];//��������
    string features;//��������
}VertexType;//����
typedef struct{
    VertexType  vexs[MaxVertexNum];
    //����·�����ȵ��ڽӾ���
    int  edges[MaxVertexNum][MaxVertexNum];
    int n,e;//�����ͽ����
}MGraph;//ͼ
int P[MAX],D[MAX];
int visit[200];
int dis[200];

void create(MGraph* G);
void Init_matrix(MGraph* G);
void Init_features(MGraph *G);
void Display(void);
void manager(MGraph *G);
void guest(MGraph *G);
void GetVex(MGraph *G, int v);
void ShortestPath(MGraph *G, int *P, int *D,int pos);
void ToDestination(MGraph *G, int v, int w);
void InsertArc(MGraph *G,int v, int w);
int login(void);
void DeleteArc(MGraph *G ,int v,int w);
void recreate_graph(MGraph *G);
void del_place(MGraph *G,int code);
void change_palce(MGraph *G,int code);
void add_place(MGraph *G);

int main(void)
{
    // ���ļ��ж�ȡͼ�������ڽӾ���洢
    MGraph* G=(MGraph*)calloc(1,sizeof(MGraph));
    int flag=-1;
    create(G);
    //��½
    while(flag==-1)
        flag=login();
    system("cls");
    //����������  ��������տռ�
    if(flag)
        manager(G);
    else
       guest(G);
    free(G);
    return 0;
}


void create(MGraph* G)
{
    FILE* fp = fopen("message.txt","r");
    char message[300];
    G->e = 0;
    if(fp==NULL)
    {
        cout<<"�ļ���ʧ��\n";
        exit(0);
    }
    //���ļ��ж�ȡ���ڽ�������������Ϣ�������ڽӾ���洢�ṹ
    while(fgets(message,300,fp)!=NULL)
    {
        int id,id2,distance=0;
        char name[20],relation[200];
        sscanf(message,"%d %s",&id,name);
        strcpy(G->vexs[id].name,name);
        fgets(relation,200,fp);
        relation[strlen(relation)-1]='\0';
        char* token = strtok(relation," ");
        id2 = atoi(token);
        token = strtok(NULL," ");
        distance = atol(token);
        G->edges[id][id2] = distance;
        G->e += 1;
        //�����ļ��ṹ��ȡÿ�е����ݲ������ݽ��зָ�
        while(token!=NULL){
            token = strtok(NULL," ");
            if(!token)
                break;
            id2 = atoi(token);
            token = strtok(NULL," ");
            distance = atol(token);
            G->edges[id][id2] = distance;
            G->e += 1;
        }
        G->n = id;
    }
    G->e/=2;
    //��ʼ�������еĵ� ������ͨ�ĵ���Ϊ���ֵ������ʼ��ÿ�����������
    Init_matrix(G);
    Init_features(G);
    fclose(fp);
}
void Init_features(MGraph *G)
{
    //���ù����õ��ڽӾ�������ʼ��������Ϣ
    for(int i = 1;i <= G->n;i++)
    {
        G->vexs[i].features = "";
        for(int j = 1;j<=G->n;j++)
        {
            if(G->edges[i][j]!=MAX &&i!=j)
            {
                string s(G->vexs[j].name);
                G->vexs[i].features += s+",����Ϊ��"+std::to_string(G->edges[i][j])+"�ס�\n";
            }
        }
    }
}
void GetVex(MGraph *G, int v)
//���ڶԾ�����н���
{
    if(v<1 ||v>G->n)
    {
        cout<<"��������ȷ�ı��"<<endl;
        return;
    }
    cout<<"�þ���Ϊ"<<G->vexs[v].name<<" �����У�"<<endl;
    cout<<G->vexs[v].features<<endl;
}
int login(void)
{
    //��½���� �˻���Ϣ���ļ��ж�ȡ ����һ��״ֵ̬ -1��ʾʧ�� 0 1��ʾ�οͺ͹���Ա
	char account[20]={0},password[16]={0},buff[50]={0};
	char account_right[20],password_right[20];
	FILE* fp;
	if((fp=fopen("login.txt","r"))==NULL){
		cout<<"�ļ���ʧ��";
		exit(0);
	}
	cout<<"�����������˺�:";
	fgets(account,19,stdin);
    account[strlen(account)-1] = '\0';
	cout<<"��������������(���ִ�Сд):";
    //���Զ����������ʽ����
	for(int i = 0;i < 16;)
    {
        char a;
        if((a=getch())!='\r') {
        	if(a=='\b' && i > 0){
        		cout<<"\b \b";
        		i--;
        		password[i] = '\0';
        		continue;
        	}
        	else if(a!='\b'){
            	cout<<"*";
            	password[i] = a;
            }
        }
        else{
            password[i]='\0';
            break;
        }
        i++;
    }
    //���ļ��е���Ϣ���бȶ�
	while(fgets(buff,50,fp)) {
		int flag;
		sscanf(buff,"%s %s %d",account_right,password_right,&flag);
		if(strcmp(account,account_right)==0 && strcmp(password,password_right) == 0)
		{
			fclose(fp);
			return flag;
		}
	}
	cout<<endl<<"��¼ʧ�ܣ��˺Ż��������"<<endl<<endl;
    fclose(fp);
	return -1;
}
void ToDestination(MGraph *G, int v, int w)
{
    //����Dijkstra�㷨������������·��

    if(v>G->n ||w>G->n ||v<1 ||w<1) {
        cout<<"���ݷǷ�������������!"<<endl;
        return;
    }
    int j;
    vector<int>FInal(G->n+1,0);
    FInal[v] = 1;
    for(int i = 1;i <= G->n;i++)
    {
        D[i] = G->edges[v][i];
        P[i] = 0;
    }
    D[v] = 0,P[v] = -1;
    for(int i = 1;i <=G->n;i++)
    {
        if(i==v)
            continue;
        int min = MAX + 1;
        for(int k =1;k <= G->n;k++)
        {
            if(FInal[k]==0&&D[k]<min)
            {
                j = k;
                min = D[k];
            }
        }
        FInal[j] = 1;
        for(int k = 1;k<=G->n;k++)
        {
            if(FInal[k]==0 && D[j]+G->edges[j][k]<D[k])
            {
                D[k] = D[j]+G->edges[j][k];
                P[k] = j;
            }
        }
    }
    int pre;
    stack<string>res;
    cout<<G->vexs[v].name<<"��"<<G->vexs[w].name<<"�����·��Ϊ:"<<D[w]<<endl;
    pre = P[w];
    while(pre>=v)
    {
        string tmp(G->vexs[pre].name);
        res.push(tmp);
        pre = P[pre];
    }
    cout<<G->vexs[v].name;
    while(!res.empty())
    {
        cout<<"->"+res.top();
        res.pop();
    }
    cout<<"->"<<G->vexs[w].name<<endl;
}
void InsertArc(MGraph *G,int v, int w)
{
    if(v==w ||v>G->n||v<1||w>G->n||w<1)
    {
        cout<<"������������������!"<<endl;
        return;
    }
    if(G->edges[v][w]!=MAX)
        cout<<"�������֮���Ѿ����ڵ�·"<<endl;
    else
    {
        int v1=v,v2=w,dis;
        cout<<"������Ҫ��ӵ�·��������֮��ľ���:";
        cin>>dis;
        G->edges[v1][v2] = G->edges[v2][v1] = dis;
        cout<<"����ɹ�"<<endl;
        Init_features(G);
    }
}
void DeleteArc(MGraph *G ,int v,int w)
{
    if(G->edges[v][w]!=MAX &&v!=w){
        G->edges[v][w] = G->edges[w][v] = MAX;
        cout<<"ɾ���ɹ�";
        Init_features(G);
    }
    else
        cout<<"��������䲻���ڵ�·!"<<endl;
}
void Init_matrix(MGraph* G)
{
    //���ڽӾ����ʼ��  ��·�ĸ�ֵΪMAX
    for(int i = 1;i<= G->n;i++)
        for(int j = 1;j <=G->n;j++)
            if(G->edges[i][j]==0 &&i!=j)
                G->edges[i][j] = MAX;
}
void Display(void)
{
    //���ļ��ж�ȡ���о�����б�
    FILE* fp = fopen("places.txt","r");
    char message[100];
    if(fp==NULL)
    {
        cout<<"�ļ���ʧ��\n";
        exit(0);
    }
    while(fgets(message,100,fp))
    {
        cout<<message;
    }
    fclose(fp);
}
void recreate_graph(MGraph *G)
{
    FILE* fp = fopen("temp.txt","w");
    if(!fp)
    {
        cout<<"�ļ��򿪻򴴽�ʧ��!"<<endl;
        exit(0);
    }
    for(int i = 1;i <=G->n;i++)
    {
        //�����ڽӾ����е����ݺ�ԭ�����ļ���ʽ�ؽ��ڽӾ���
        char result[100];
        sprintf(result,"%d %s\n",i,G->vexs[i].name);
        fputs(result,fp);
        for(int j = 1;j <=G->n;j++)
        {
            if(G->edges[i][j]!=0 && G->edges[i][j]!=MAX)
            {
                sprintf(result,"%d %d ",j,G->edges[i][j]);
                fputs(result,fp);
            }
        }
        fputs("\n",fp);
    }
    fclose(fp);
    remove("message.txt");
    rename("temp.txt","message.txt");
}
void ShortestPath(MGraph *G, int *P, int *D,int pos)
{
    int j;//����Dijkstra�㷨���������������·��
    vector<int>FInal(G->n+1,0);
    FInal[pos] = 1;
    for(int i = 1;i <= G->n;i++)
    {
        D[i] = G->edges[pos][i];
        P[i] = 0;
    }
    D[pos] = 0,P[pos] = -1;
    for(int i = 1;i <=G->n;i++)
    {
        if(i==pos)
            continue;
        int min = MAX + 1;
        for(int k =1;k <= G->n;k++)
        {
            if(FInal[k]==0&&D[k]<min)
            {
                j = k;
                min = D[k];
            }
        }
        FInal[j] = 1;
        for(int k = 1;k<=G->n;k++)
        {
            if(FInal[k]==0 && D[j]+G->edges[j][k]<D[k])
            {
                D[k] = D[j]+G->edges[j][k];
                P[k] = j;
            }
        }
    }
    int pre;
    for(int i = 1;i <= G->n;i++)
    {
        if(i==pos)
            continue;
        stack<string>res;
        cout<<G->vexs[pos].name<<"��"<<G->vexs[i].name<<"�����·��Ϊ:"<<D[i]<<endl;
        cout<<G->vexs[pos].name;
        pre = P[i];
        while(pre>=pos)
        {
            string tmp(G->vexs[pre].name);
            res.push(tmp);
            pre = P[pre];
        }
        //�����ʱ�����һ��ջ���洢�ַ���
        while(!res.empty())
        {
            cout<<"->"+res.top();
            res.pop();
        }
        cout<<"->"<<G->vexs[i].name<<endl;
    }
}
void manager(MGraph *G)
{//����Աϵͳ����Ҫ�ṹ����һ��switch���
    int flag =1,option,code,code2,mark=0;
    while(flag){
        cout<<"\n��ӭ����Ա���ʱ�ϵͳ!"<<endl;
        cout<<"����Խ������²�����"<<endl;
        cout<<"1.�鿴��ǰ���о���"<<endl;
        cout<<"2.����ĳһ����"<<endl;
        cout<<"3.�鿴ĳһ���㵽�������н������·��"<<endl;
        cout<<"4.�鿴����ĳ�������������·��"<<endl;
        cout<<"5.���ӵ�·"<<endl;
        cout<<"6.ɾ����·"<<endl;
        cout<<"7.�޸ľ�����Ϣ"<<endl;
        cout<<"8.���Ӿ���"<<endl;
        cout<<"9.ɾ������"<<endl;
        cout<<"10.�˳�����"<<endl;
        cout<<"��������Ҫ���еĲ���:";
        cin>>option;
        switch(option)
        {
            case 1:
                Display();
                break;
            case 2:
                cout<<"�����뾰����:"<<endl;
                cin>>code;
                GetVex(G,code);
                break;
            case 3:
                for(int i = 1;i<=G->n;i++){
                    cout<<endl;
                    ShortestPath(G,P,D,i);
                }
                break;
            case 4:
                cout<<"��������������ı��:"<<endl;
                cin>>code>>code2;
                ToDestination(G,code,code2);
                break;
            case 5:
                cout<<"����������λ�õı��:";
                cin>>code>>code2;
                InsertArc(G,code,code2);
                mark = 1;
                break;
            case 6:
                cout<<"����������λ�õı��:";
                cin>>code>>code2;
                DeleteArc(G,code,code2);
                mark = 1;
                break;
            case 7:
                cout<<"������Ҫ�޸ĵľ�����:"<<endl;
                cin>>code;
                change_palce(G,code);
                mark = 1;
                break;
            case 8:
                add_place(G);
                mark = 1;
                break;
            case 9:
                cout<<"������Ҫɾ���ľ�����:"<<endl;
                cin>>code;
                mark = 1;
                del_place(G,code);
                break;
            case 10:
                flag = 0;
                break;
            default:
                cout<<"������������������!"<<endl;
                break;
        }
        system("pause");
        system("cls");
    }
    if(mark)
        recreate_graph(G);
}
void guest(MGraph *G)
{
    int option,code,code2,flag=1;
    while(flag)
    {//��manager��ȣ����˹�����һЩ����Ҫ�ṹ��ͬ
        cout<<"\n��ӭ�����ʱ�����ϵͳ!"<<endl;
        cout<<"����Խ������²�����"<<endl;
        cout<<"1.�鿴��ǰ���о���"<<endl;
        cout<<"2.����ĳһ����"<<endl;
        cout<<"3.�鿴ĳһ���㵽�������н������·��"<<endl;
        cout<<"4.�鿴����ĳ�������������·��"<<endl;
        cout<<"5.�˳�����"<<endl;
        cout<<"��������Ҫ���еĲ���:";
        cin>>option;
        switch(option)
        {
            case 1:
                Display();
                break;
            case 2:
                cout<<"�����뾰����:"<<endl;
                cin>>code;
                GetVex(G,code);
                break;
            case 3:
                for(int i = 1;i<=G->n;i++){
                    cout<<endl;
                    ShortestPath(G,P,D,i);
                }
                break;
            case 4:
                cout<<"��������������ı��:"<<endl;
                cin>>code>>code2;
                ToDestination(G,code,code2);
                break;
            case 5:
                flag=0;
                break;
            default:
                cout<<"������������������!"<<endl;
                break;
        }
        system("pause");
        system("cls");
    }
}
void del_place(MGraph *G,int code)
{
    //ɾ���ڵ㲢�Ծ����������г�ʼ��
    if(code>G->n ||code < 1)
    {
        cout<<"�õ㲻����!"<<endl;
        return;
    }
    for(int i = 1;i <= G->n;i++)
    {
        if(G->edges[code][i]!=0 && G->edges[code][i]!=MAX)
            G->edges[code][i] = G->edges[i][code] = MAX;
    }
    cout<<"ɾ���ɹ�!"<<endl;
    G->n-=1;
    Init_features(G);
}
void change_palce(MGraph *G,int code)
{
    int node,dis;
    cout<<"��������Ҫ�ı����"<<code<<"���ڵĽ��ı��:";
    cin>>node;
    cout<<"������һ���µĵľ���"<<endl;
    cin>>dis;
    G->edges[code][node] = G->edges[node][code] = dis;
    Init_features(G);
    cout<<"�޸ĳɹ�!"<<endl;
}
void add_place(MGraph *G)
{
    //��Ӿ��㲢��ʼ����������
    char name[20];
    int n;
    cout<<"��������Ҫ��ӵľ������ƣ�"<<endl;
    cin>>name;
    cout<<"��������Ҫ����ĵ�·����:";
    cin>>n;
    cout<<"��������õ����ڵĽ��;���:"<<endl;
    G->n+=1;
    strcpy(G->vexs[G->n].name,name);
    for(int i = 1;i<=n;i++)
    {
        int code,dis;
        cin>>code>>dis;
        G->edges[code][G->n] = G->edges[G->n][code] = dis;
    }
    Init_features(G);
}
