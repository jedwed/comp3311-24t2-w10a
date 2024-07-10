CREATE OR REPLACE FUNCTION my_sum (curr_state numeric, curr_arg numeric) 
RETURNS numeric AS $$
BEGIN
    RETURN curr_state + curr_arg;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE AGGREGATE my_sum (numeric) (
    SFUNC = my_sum,
    STYPE = numeric,
    INITCOND = 0
);

CREATE TYPE avg_state AS (state_sum numeric, state_length integer);

CREATE OR REPLACE FUNCTION my_avg (curr_state avg_state, curr_arg numeric)
RETURNS avg_state AS $$
BEGIN
    curr_state.state_sum := curr_state.state_sum + curr_arg;
    curr_state.state_length := curr_state.state_length + 1;
    RETURN curr_state;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION finalise (final_state avg_state) RETURNS numeric AS $$
BEGIN
    RETURN final_state.state_sum / final_state.state_length;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE AGGREGATE my_avg (numeric) (
    SFUNC = my_avg,
    STYPE = avg_state,
    INITCOND = '(0,0)',
    FINALFUNC = finalise
);
