function s = pathSubstruct(path)
% PATHSUBSTRUCT  Convert a dotted path string into a substruct usable with
% SUBSREF / SUBSASGN.
%
%   s = pathSubstruct('string.sigma0_Hz')
%   s = pathSubstruct('pickups(1).x_m')
%
% The returned s can be passed to subsref/subsasgn to read or write the
% nested field:
%
%   v = subsref(p, pathSubstruct('pickups(1).x_m'));
%   p = subsasgn(p, pathSubstruct('pickups(1).x_m'), 0.042);
%
% Grammar accepted:
%   <field>         := [A-Za-z_]\w*
%   <index>         := integer in parentheses
%   <path>          := <field>(\(<index>\))?(\.<field>(\(<index>\))?)*

if ~(ischar(path) || (isstring(path) && isscalar(path)))
    error('pathSubstruct:badInput', ...
          'path must be a char row or scalar string; got %s.', class(path));
end
path = char(path);

tokens = regexp(path, '([A-Za-z_]\w*)(?:\((\d+)\))?', 'tokens');
if isempty(tokens)
    error('pathSubstruct:unparseable', ...
          'Could not parse path "%s".', path);
end

args = {};
for i = 1:numel(tokens)
    tok = tokens{i};
    args{end+1} = '.';       %#ok<AGROW>
    args{end+1} = tok{1};    %#ok<AGROW>
    if numel(tok) >= 2 && ~isempty(tok{2})
        args{end+1} = '()';                      %#ok<AGROW>
        args{end+1} = {str2double(tok{2})};      %#ok<AGROW>
    end
end

s = substruct(args{:});
end
