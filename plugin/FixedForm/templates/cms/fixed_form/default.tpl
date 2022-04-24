{% extends "master.tpl" %}

{% block links %}
  <link rel="stylesheet" href="{{ config.global.assets_path }}style/cms/default.css">
{% endblock %}

{% block main %}
  <input type="hidden" name="mode" value="fixed-form~receive:remove">
  <div class="explorer-list">
    <h1 class="headline">定型文一覧</h1>
    <div class="explorer-body">
      {% for unit in fixedForms %}
        {% if loop.first %}
          <table>
            <thead>
              <tr>
                <td>タイプ</td>
                <td>名称</td>
                <td>作成日</td>
                <td>更新日</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </thead>
            <tbody>
        {% endif %}
        <tr>
          <td>{{ unit.tags }}</td>
          <td class="spacer link"><a href="?mode=fixed-form~response:edit&amp;id={{ unit.id|url_encode }}">{{ unit.title }}</a></td>
          <td class="date">{{ unit.create_date|date('Y年n月j日 H:i') }}</td>
          <td class="date">{{ unit.modify_date|date('Y年n月j日 H:i') }}</td>
          <td class="button"><a href="?mode=fixed-form~response:edit&amp;id={{ unit.id|url_encode }}">編集</a></td>
          <td class="button reddy"><label><input type="radio" name="delete" value="{{ unit.id }}">削除</label></td>
        </tr>
        {% if loop.last %}
            </tbody>
          </table>
        {% endif %}
      {% else %}
        <p class="notice">定型文の登録がありません</p>
      {% endfor %}
    </div>
    <div class="footer-controls">
      <nav class="links">
        {% if apps.hasPermission('cms.template.create') %}
          <a href="?mode=fixed-form~response:edit"><mark>+</mark>新規定型文</a>
        {% else %}
          <span>&nbsp;</span>
        {% endif %}
      </nav>
      <nav class="pagination">
        {% include 'pagination.tpl' %}
      </nav>
    </div>
  </div>
{% endblock %}
