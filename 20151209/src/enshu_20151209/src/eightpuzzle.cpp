#include <iostream>
#include <queue>
#include <stack>
#include <vector>
#include <cstdlib>
#include <ctime>

using namespace std;
int where_blank (vector<int> v);
int eval(vector<int> v);
vector<int> simulate (vector<int> v);
vector<int> init_state = {1,2,3,4,0,5,7,8,6};
vector<int> goal = {1,2,3,4,5,6,7,8,0};
enum {
	UP,RIGHT,LEFT,DOWN
};

int where_blank (vector<int> v)
{
	for (int i = 0; i < 9; i++) {
		if (v[i] == 0) {
//			cout << i << endl;
			return i;
		}
	}
}

int eval(vector<int> v)
{
	int ret = 0;
	vector<int> state = simulate(v);
	for (int i = 0; i < 9; i++) {
		if (state[i] == goal[i]) {
			ret++;
		}
	}
	return -(ret + v.size());
}

vector<int> simulate (vector<int> v)
{
	for (int i = 0; i < v.size(); i++) {
		cout << v[i];
	}
	cout << endl;
	vector<int> state = {1,2,3,4,0,5,7,8,6};
	for (int i = 0; i < v.size(); i++) {
		int b = where_blank(state);
		int num;
		switch(v[i]) {
			case UP:
			num = state[b-3];
			state[b-3] = 0;
			state[b] = num;
			break;
			case DOWN:
			num = state[b+3];
			state[b+3] = 0;
			state[b] = num;
			break;
			case RIGHT:
			num = state[b+1];
			state[b+1] = 0;
			state[b] = num;
			break;
			case LEFT:
			num = state[b-1];
			state[b-1] = num;
			state[b-1] = 0;
			state[b] = num; 
			break;
		}
	}
	cout << state[0] <<state[1]<<state[2]<<endl<<state[3]<<state[4]<<state[5]<<endl<<state[6]<<state[7]<<state[8]<<endl;
	return state;
}

bool is_goal(vector<int> v)
{
	for (int i = 0; i < 9; i++) {
		if (v[i] != goal[i]) {
			return false;
		}
	}
	return true;
}

int main()
{
	srand(time(NULL));
	priority_queue<pair<int, vector<int> > > pq;
	vector<int> init_v = {};
	pair<int, vector<int> > p = make_pair(eval(init_v), init_v);
	pq.push(p);
	while (1) {
		auto p_top = pq.top();
		vector<int>state = simulate(p_top.second);
		pq.pop();
		int blank = where_blank(state);
		for(int i = 0; i < p_top.second.size(); i++) {
//			cout << p_top.second[i] << ",";

		}
		cout << endl;
		if (is_goal(state)) {
			for(int i = 0; i < p_top.second.size(); i++) {
				cout << p_top.second[i] << ",";

			}
			cout << endl;
			return 0;
		}
		else {
			vector<int> temp_v = p_top.second;
			int temp_eval;
			if (blank % 3 != 0) {
				temp_v = p_top.second;
				temp_v.push_back(LEFT);
				temp_eval = eval(temp_v);
				pq.push(make_pair(temp_eval, temp_v));
			}
			if (blank % 3 != 2) {
				temp_v = p_top.second;
				temp_v.push_back(RIGHT);
				temp_eval = eval(temp_v);
				pq.push(make_pair(temp_eval, temp_v));
			}
			if (blank > 2) {
				temp_v = p_top.second;
				temp_v.push_back(UP);
				temp_eval = eval(temp_v);
				pq.push(make_pair(temp_eval, temp_v));
			}
			if (blank <6) {
				temp_v = p_top.second;
				temp_v.push_back(DOWN);
				temp_eval = eval(temp_v);
				pq.push(make_pair(temp_eval, temp_v));
			}
		}
//		getchar();
	}
	return 0;

}