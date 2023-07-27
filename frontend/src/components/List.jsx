const EmptyState = ({title, children}) => {
  return(
    <div className="empty-state">
      <div className="empty-state-title">No {title.toLowerCase()}</div>
      { children }
    </div>
  )
}

const List = ({ title, hideTitle, items, children }) => {
  const formattedTitle = title.toLowerCase()
  return(
    <section id={formattedTitle}>
      { !hideTitle && <h4 className="section-title">{title}</h4> }
      <div className={formattedTitle}>
        { items?.length > 0
          ? items
          : <EmptyState children={children} title={formattedTitle} />
        }
      </div>
    </section>
  )
}

export { List, EmptyState }